# card.baily.life — v1 技术方案

> 目标：信用卡账单日 / 还款日 / 年费日 提醒平台。知识星球小圈子内测。

## 技术栈

| 层 | 选型 |
|---|---|
| 前端 | SvelteKit + TypeScript + TailwindCSS |
| 部署 | Cloudflare Pages（前端 + SvelteKit endpoints） |
| 后端运行时 | Cloudflare Workers（随 SvelteKit adapter-cloudflare 一起） |
| 数据库 | Cloudflare D1（SQLite） |
| ORM | Drizzle ORM |
| 邮件 | Cloudflare Email Service（public beta） |
| 定时任务 | Cloudflare Cron Triggers（每小时） |
| 推送通道 | CF Email / Bark / PushPlus |
| 域名 | `card.baily.life`（CF DNS 托管） |

**零外部依赖**：除了 CF 自身，没有任何第三方 SaaS。

---

## 目录结构

```
card-baily-life/
├── docs/
│   ├── v1-plan.md           # 本文档
│   └── catalog-seed.md      # 卡片库初始数据
├── src/
│   ├── lib/
│   │   ├── db/              # Drizzle schema + client
│   │   ├── auth/            # 魔法链接、session
│   │   ├── notify/          # email/bark/pushplus 发送器
│   │   └── reminder/        # 提醒计算逻辑
│   ├── routes/
│   │   ├── +layout.svelte
│   │   ├── +page.svelte           # 首页
│   │   ├── login/
│   │   ├── auth/verify/           # 魔法链接回调
│   │   ├── dashboard/
│   │   ├── cards/
│   │   │   ├── add/
│   │   │   └── [id]/edit/
│   │   ├── settings/
│   │   │   └── notifications/
│   │   └── api/                   # server endpoints
│   └── hooks.server.ts
├── migrations/              # D1 SQL migrations
├── wrangler.toml
├── drizzle.config.ts
├── svelte.config.js
├── tailwind.config.ts
└── package.json
```

---

## 数据库 Schema（D1 / SQLite）

```sql
-- 邮箱白名单：只有白名单内的邮箱能收到魔法链接
CREATE TABLE allowlist (
  email TEXT PRIMARY KEY,
  note TEXT,                        -- 备注，比如"知识星球 @张三"
  added_at INTEGER NOT NULL
);

CREATE TABLE users (
  id TEXT PRIMARY KEY,              -- UUID
  email TEXT UNIQUE NOT NULL,
  created_at INTEGER NOT NULL,
  last_login_at INTEGER
);

-- 魔法链接 token（一次性，15 分钟过期）
CREATE TABLE magic_links (
  token TEXT PRIMARY KEY,           -- 32 字节随机
  email TEXT NOT NULL,
  expires_at INTEGER NOT NULL,
  used_at INTEGER
);

-- 登录 session（30 天）
CREATE TABLE sessions (
  id TEXT PRIMARY KEY,              -- 32 字节随机
  user_id TEXT NOT NULL REFERENCES users(id),
  expires_at INTEGER NOT NULL,
  created_at INTEGER NOT NULL
);

-- 卡片主库（我手动维护）
CREATE TABLE card_catalog (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  country TEXT NOT NULL,            -- 'CN' | 'US'
  bank_name TEXT NOT NULL,          -- '招商银行'
  card_name TEXT NOT NULL,          -- 'Visa 无限卡'
  card_tier TEXT,                   -- '无限' / '白金' / '钻石'
  image_url TEXT,
  annual_fee_cny INTEGER,           -- 纯参考，用户自填为准
  notes TEXT
);

-- 用户的卡
CREATE TABLE user_cards (
  id TEXT PRIMARY KEY,              -- UUID
  user_id TEXT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  catalog_id INTEGER REFERENCES card_catalog(id),  -- NULL 表示自定义卡
  custom_name TEXT,                 -- catalog_id 为空时必填
  last_four TEXT NOT NULL,          -- 尾号 4 位
  statement_day INTEGER NOT NULL,   -- 账单日 1-31
  due_day INTEGER NOT NULL,         -- 还款日 1-31
  annual_fee_month INTEGER,         -- 年费月 1-12（可空）
  annual_fee_day INTEGER,           -- 年费日 1-31（可空）
  lead_days INTEGER NOT NULL DEFAULT 3,  -- 提前 N 天提醒
  created_at INTEGER NOT NULL,
  CHECK (catalog_id IS NOT NULL OR custom_name IS NOT NULL),
  CHECK (statement_day BETWEEN 1 AND 31),
  CHECK (due_day BETWEEN 1 AND 31)
);

-- 用户通知渠道
CREATE TABLE notification_channels (
  id TEXT PRIMARY KEY,
  user_id TEXT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  type TEXT NOT NULL,               -- 'email' | 'bark' | 'pushplus'
  config TEXT NOT NULL,             -- JSON: {"device_key":"..."} / {"token":"..."}
  enabled INTEGER NOT NULL DEFAULT 1,
  created_at INTEGER NOT NULL
);

-- 已发送提醒日志（用于幂等，避免重复推送）
CREATE TABLE reminder_sent (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  user_card_id TEXT NOT NULL,
  reminder_type TEXT NOT NULL,      -- 'statement' | 'due' | 'annual_fee'
  target_date TEXT NOT NULL,        -- 'YYYY-MM-DD'
  channel TEXT NOT NULL,
  sent_at INTEGER NOT NULL,
  UNIQUE (user_card_id, reminder_type, target_date, channel)
);
```

---

## 页面路由

| 路径 | 用途 | 需登录 |
|---|---|---|
| `/` | 首页：介绍 + 登录入口 | 否 |
| `/login` | 输入邮箱 → 发魔法链接 | 否 |
| `/auth/verify?token=...` | 魔法链接回调，建立 session | 否 |
| `/dashboard` | 我的卡片 + 近期提醒 | 是 |
| `/cards/add` | 添加卡片（选库 / 自定义） | 是 |
| `/cards/:id/edit` | 编辑卡片 | 是 |
| `/settings/notifications` | 通知渠道管理 | 是 |
| `/logout` | 登出 | 是 |

## API endpoints

| 方法 | 路径 | 用途 |
|---|---|---|
| POST | `/api/auth/magic-link` | 发魔法链接 |
| GET  | `/api/auth/verify` | 验证 token，set-cookie |
| POST | `/api/auth/logout` | 销毁 session |
| GET  | `/api/cards` | 列出我的卡 |
| POST | `/api/cards` | 新增卡 |
| PATCH | `/api/cards/:id` | 编辑卡 |
| DELETE | `/api/cards/:id` | 删卡 |
| GET  | `/api/catalog?country=CN` | 卡片库 |
| GET  | `/api/channels` | 我的通知渠道 |
| POST | `/api/channels` | 新增通知渠道 |
| DELETE | `/api/channels/:id` | 删除通知渠道 |

---

## 核心逻辑

### 账单日 / 还款日的日期计算

存的是 `statement_day` / `due_day`（1-31 整数），不是具体日期。

当月实际触发日 = `min(day, 当月天数)`
例：2 月账单日配置为 30，实际触发 = 2 月 28 日（闰年 29 日）。

### 年费日

存 `(annual_fee_month, annual_fee_day)`，一年一次。可空（部分卡终身免年费）。

### 提醒调度

**CF Cron Trigger：每小时的第 0 分触发一次（`0 * * * *`）**。

每次触发逻辑（简化版）：

```
today = UTC 当前日期 + 8h（转北京时间）
for each user_card:
  targets = [
    (statement_day_of_this_month, 'statement'),
    (due_day_of_this_month, 'due'),
    (annual_fee_this_year, 'annual_fee'),  # 若有
  ]
  for (target_date, type) in targets:
    if today == target_date - lead_days OR today == target_date:
      # 每天 9 点北京时间左右发一次（判断 UTC hour == 1）
      if current_hour_is_9am_beijing:
        for channel in user.channels:
          if not already_sent(user_card, type, target_date, channel):
            send(channel, render_message(user_card, type, target_date))
            log_sent(...)
```

**幂等保证**：`reminder_sent` 表 `UNIQUE(user_card_id, reminder_type, target_date, channel)`，同一天同一条提醒同一渠道只会成功发一次。

### 通知渠道配置

- **Email**：直接用用户注册邮箱，配置只存 `{"email": "..."}`（就是 user.email）
- **Bark**：`{"device_key": "xxxxxxxx", "server": "https://api.day.app"}`
- **PushPlus**：`{"token": "xxxxxxxx"}`

发送时统一接口：`notify(channel, title, body)`，内部分发。

---

## 安全 & 隐私

- **不存完整卡号**，只存尾号 4 位
- 所有 token / session 都是 32 字节 `crypto.randomUUID()` 或 `crypto.getRandomValues`
- Session cookie：`HttpOnly; Secure; SameSite=Lax; Max-Age=2592000`（30 天）
- 魔法链接 token：15 分钟有效，用过即废
- 白名单拦截：非 allowlist 邮箱不发魔法链接（但返回一样的 success，防枚举）
- 频率限制：同一邮箱 60 秒内最多 1 次魔法链接请求（Workers KV 计数）

---

## 里程碑

**M1（脚手架 + 登录）** — 预计 1-2 天
- 项目初始化（SvelteKit + Tailwind + Drizzle + wrangler）
- CF Pages / Workers / D1 创建绑定
- `card.baily.life` DNS + SSL
- 邮箱白名单 + 魔法链接登录 + session
- 空 `/dashboard`

**M2（卡片 CRUD）** — 1-2 天
- 手动录入 30-50 张常见国内卡（招商 / 建行 / 中信 / 交通 / 浦发 / 光大 / 平安 / 工行 / 农行 / 广发）
- 添加卡：选库 or 自定义
- 编辑 / 删除
- Dashboard 展示近 30 天提醒预览

**M3（邮件提醒）** — 1 天
- CF Email Service 配置 & 域名验证
- Cron Trigger + 调度逻辑
- 发送测试

**M4（Bark + PushPlus）** — 1 天
- 渠道设置页
- 三通道并行发送 + 幂等

**M5（打磨）** — 1 天
- 错误页、loading 态
- 移动端 UI 验收
- 邀请第一批星球朋友试用

**总计：约一周工作量**（不含内容录入）。

**推到 v2：** 卡片权益管理、权益到期提醒、消费统计、航司/酒店衍生功能。

---

## 开工前你需要准备的

1. Cloudflare 账号，`baily.life` 已在 CF DNS 托管 ✅（既然 Hugo 站打算放 CF Pages）
2. 本地装好 `wrangler` CLI 并 `wrangler login`
3. 一个 GitHub 仓库（私有），我把代码推上去后 CF Pages 绑定 git 自动部署
4. （等 M4）一个 Bark 和 PushPlus token，用于你自己测试

我开工前还需要你决定的：
- GitHub 仓库名：建议 `card-baily-life`（公开 or 私有）
- 卡片库首批录入范围：我默认按上面 10 家银行各挑 3-5 张常见卡，你有补充或删减告诉我

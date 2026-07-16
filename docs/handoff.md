# card-baily-life Handoff

## 这个项目是做什么的

这是一个信用卡提醒网站（贝利卡管家，https://card.baily.life）。

用途：
- 记录每张信用卡的账单日、还款日、年费日
- 到期前通过 Bark / PushPlus 推送提醒
- 附带卡片推荐落地页、机场休息室查询、管理员卡库后台

当前技术栈：
- SvelteKit（Svelte 5）+ TypeScript
- Cloudflare Pages
- Cloudflare D1 + Drizzle ORM
- Clerk（登录）
- 独立 Worker `workers/reminder-cron`（Cron 定时触发提醒）

## 现在做到哪里了

`M1`（脚手架 + 登录 + D1 接通）、`M2`（卡片 CRUD + 提醒预览）、`M3`（提醒调度与发送）都已完成。

当前已有的能力：
- 卡片库（含 Cardentify 导入的 361 张卡面）、添加 / 编辑 / 删除卡片、可视化卡面选择
- Dashboard（含 mobile-dashboard）展示卡片列表和未来 30 天提醒预览；无 D1 时回退演示卡片
- 手机端伪 App 壳：底栏导航（卡片 / 提醒 / 贵宾厅 / 我的）、安全区与移动顶栏；设计说明见 `docs/design/`
- 提醒调度：`workers/reminder-cron` 定时 POST `/api/reminders/run`（Bearer `REMINDER_RUN_TOKEN`），经 Bark / PushPlus / Telegram / 飞书 / 钉钉 发送（共享 `src/lib/notifications/senders.ts`），`reminder_sent` 表去重
- Clerk 私有元数据 `notify` 里的通知配置会在登录时同步进本地 D1（`src/lib/notifications/clerk-sync.ts`，`users.notify_synced_at` 节流 5 分钟），cron 推送读的是本地表
- 统一账单日银行（建行、交行、广发等）同日提醒自动合并为一条
- 通知偏好（账单 / 还款 / 年费 / 活动分开开关）+ 每张卡独立提醒开关
- 登录：Clerk（`/sign-in`、`/sign-up`）为主，兼容旧密码 + session cookie 登录；`/me` 个人设置、修改密码
- 管理后台：`/admin/catalog`（卡库维护）、`/admin/featured`（精选活动），带 MiniMax AI 自动填充
- 推荐办卡落地页 `/refer/*`、机场休息室 `/lounges`（含评论）
- 帮助页：Bark / PushPlus / Telegram 配置教程
- 安全加固与 D1 备份（见 `docs/security-runbook.md`，本地 LaunchAgent 每 7 天备份到 iCloud）

## Cloudflare 上需要的配置

- D1 binding：`DB`
- 环境变量 / secrets（Pages）：
  - `APP_URL=https://card.baily.life`
  - `CRM_API_BASE`、`CRM_API_KEY`
  - `MINIMAX_API_BASE_URL`、MiniMax key
  - `PUBLIC_CLERK_PUBLISHABLE_KEY`、`CLERK_SECRET_KEY`
  - `REMINDER_RUN_TOKEN`（与 reminder-cron Worker 共用）
- reminder-cron Worker（`workers/reminder-cron/wrangler.toml`）：`REMINDER_ENDPOINT`、`REMINDER_RUN_TOKEN`

配置文件在：
- [wrangler.toml](../wrangler.toml)

## 数据库 migration 注意事项（重要）

远程 D1 用 `wrangler d1 migrations apply` 管理，**按文件名**记录在 `d1_migrations` 表里。因此：

- **已应用的 migration 文件不能重命名、不能修改内容**——重命名会被当成新文件重新执行，直接报错或损坏数据。
- 历史遗留：`0009_add_featured_promotions.sql` 和 `0009_add_variants.sql` 编号重复，但都已应用到生产库，**保持原名，不要动**。
- 曾存在的 `0007_update_card_images 2.sql`（Finder 复制产生）已应用后被删除，`d1_migrations` 里仍有记录，属正常。
- 新 migration 从 `0015` 开始编号，确保编号唯一（`0014_add_clerk_user_sync.sql` 已于 2026-07-10 应用到远程）。
- 改表结构前先跑 `npm run backup:d1`。

## 当前登录方式

- 主要登录：Clerk（`/sign-in`、`/sign-up`），首次登录会在 D1 `users` 表建立本地映射
- 兼容：旧的密码登录 + session cookie（`src/lib/auth/`）
- `/login` 只保留兼容跳转

## 新电脑最简单的接手方法

1. 从 GitHub 拉这个仓库
2. `npm install`
3. `wrangler login`
4. 让 AI 先读这个文件

```bash
git clone https://github.com/bailylu/card-baily-life.git
cd card-baily-life
npm install
wrangler login
```

检查项目是否正常：

```bash
npm run check
npm test
npm run build
```

本地模拟 Cloudflare Pages：

```bash
npx wrangler pages dev .svelte-kit/cloudflare
```

## 如果让 AI 接手，直接这样说

```text
继续 card-baily-life 项目。先读 docs/handoff.md、wrangler.toml、package.json，再告诉我当前进度和下一步怎么做。
```

## 这个项目里最重要的几个文件

- [docs/handoff.md](handoff.md)：接手说明（本文件）
- [docs/v1-plan.md](v1-plan.md)：产品和技术方案
- [docs/security-runbook.md](security-runbook.md)：安全与备份流程
- [wrangler.toml](../wrangler.toml)：Cloudflare 配置
- [package.json](../package.json)：运行命令
- [src/lib/cards/reminders.ts](../src/lib/cards/reminders.ts)：提醒计算核心逻辑
- [src/lib/notifications/reminder-dispatch.ts](../src/lib/notifications/reminder-dispatch.ts)：提醒发送与去重
- [migrations/](../migrations/)：数据库 migration（见上面的注意事项）

## 注意

- GitHub 主要同步的是代码；Cloudflare 后台资源配置不靠 GitHub 自动同步
- D1 表结构改动要写 migration，并执行到远程数据库（先备份）
- 正式站是否更新，取决于 Cloudflare Pages 监听的是哪个分支（当前 `main`）
- reminder-cron Worker 是独立部署的，改了 `workers/reminder-cron/` 要单独 `wrangler deploy`

如果不确定，优先让接手的人或 AI 先读这个文件，不要直接开始改代码。

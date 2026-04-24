# card-baily-life Handoff

## 这个项目是做什么的

这是一个信用卡提醒网站。

用途：
- 记录每张信用卡的账单日、还款日、年费日
- 之后按时间给用户发提醒

当前技术栈：
- SvelteKit
- TypeScript
- Cloudflare Pages
- Cloudflare D1
- Drizzle ORM

## 现在做到哪里了

当前阶段是 `M2`。

`M1` 包含：
- 项目脚手架
- Cloudflare Pages + D1 基础接通
- 白名单登录
- 魔法链接登录
- session 登录态
- 空的 `/dashboard`

当前状态：
- `DB` binding 已配置
- `APP_URL` 已配置
- D1 初始化 migration 已执行
- 本地登录链路已验证通过
- 当前为开放测试模式，无需登录即可进入
- 卡片 CRUD 页面已完成
- 添加 / 编辑页已支持可视化卡片种类选择
- Dashboard 已展示卡片列表和未来 30 天提醒预览
- 首批卡片库种子数据已写入 `migrations/0002_seed_card_catalog.sql`
- 演示用户卡片数据已写入 `migrations/0003_seed_demo_user_cards.sql`
- 无 D1 绑定或 D1 临时不可用时，Dashboard 会显示演示卡片

和 `M1` 相关的最新修复已经在这个分支里：
- 分支：`codex/m1-auth-cookie-fix`
- PR：`#1`

如果正式站要用到这次修复，需要把这个 PR 合并到 `main`。

## Cloudflare 上已经需要的配置

这个项目现在至少需要这两个配置：

- D1 binding：`DB`
- 环境变量：`APP_URL=https://card.baily.life`

配置文件在：
- [wrangler.toml](/Users/baily/card-baily-life/wrangler.toml)

数据库初始化 SQL 在：
- [migrations/0001_init.sql](/Users/baily/card-baily-life/migrations/0001_init.sql)

如果以后换新电脑，需要重新登录 Wrangler，但不需要重新手写这些配置。

## 当前登录方式

当前不做邮箱验证，也不强制登录。

现在的产品行为是：
- 用户可以直接进入使用
- 首页可以直接进入 dashboard
- `/login` 只保留兼容跳转，不再承担真实登录流程

后续如果要做正式用户系统，再决定回到邮箱验证或别的登录方式。

## 新电脑最简单的接手方法

如果你换到另一台电脑，最简单就做这几步：

1. 从 GitHub 拉这个仓库
2. 进入项目目录
3. 跑 `npm install`
4. 跑 `wrangler login`
5. 让 AI 先读这个文件

最小命令：

```bash
git clone https://github.com/bailylu/card-baily-life.git
cd card-baily-life
npm install
wrangler login
```

然后可以这样检查项目是不是正常：

```bash
npm run check
npm run build
```

如果要本地模拟 Cloudflare Pages：

```bash
npx wrangler pages dev .svelte-kit/cloudflare
```

## 如果让 AI 接手，直接这样说

在新电脑上把项目连到 GitHub 或本地仓库后，直接对 AI 说：

```text
继续 card-baily-life 项目。先读 docs/handoff.md、wrangler.toml、package.json，再告诉我当前进度和下一步怎么做。
```

如果要它继续开发，也可以直接说：

```text
继续 card-baily-life 项目，先读 docs/handoff.md，再继续做 M2。
```

这样比让 AI 从整个仓库乱猜要稳定很多。

## 这个项目里最重要的几个文件

- [docs/handoff.md](/Users/baily/card-baily-life/docs/handoff.md)：接手说明
- [docs/v1-plan.md](/Users/baily/card-baily-life/docs/v1-plan.md)：产品和技术方案
- [wrangler.toml](/Users/baily/card-baily-life/wrangler.toml)：Cloudflare 配置
- [package.json](/Users/baily/card-baily-life/package.json)：运行命令
- [migrations/0001_init.sql](/Users/baily/card-baily-life/migrations/0001_init.sql)：数据库初始化

## 下一阶段是什么

当前 `M2` 已完成：

- 卡片库录入
- 添加卡片
- 编辑卡片
- 删除卡片
- Dashboard 展示近 30 天提醒预览
- Dashboard 演示卡片回退
- 表单解析和提醒预览单元测试

下一阶段是 `M3`：

- CF Email Service 配置 & 域名验证
- Cron Trigger + 调度逻辑
- 发送测试

## 注意

- GitHub 主要同步的是代码
- Cloudflare 后台资源配置不靠 GitHub 自动同步
- D1 表结构改动要写 migration，并执行到远程数据库
- 正式站是否更新，取决于 Cloudflare Pages 监听的是哪个分支

如果不确定，优先让接手的人或 AI 先读这个文件，不要直接开始改代码。

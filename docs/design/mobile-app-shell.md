# 移动端伪 App 壳

## 目标体验

用户在手机浏览器打开时，应感觉像在用「信用卡管理 App」，而不是缩小后的桌面网站。

| 维度 | 桌面 | 手机（目标） |
|------|------|----------------|
| 导航 | 顶栏多链接 | 底栏 4 Tab |
| 布局 | 双栏（卡片 + 提醒） | 单栏，提醒置顶摘要 |
| 触控 | 鼠标 hover | ≥44px 点击区 |
| 安全区 | 无 | `env(safe-area-inset-*)` |
| 滚动 | 页面滚动 | 内容区滚动，壳固定 |

## 信息架构（登录后）

```
┌─────────────────────────┐
│  顶栏：标题 + 主操作     │  ← 固定 / sticky
├─────────────────────────┤
│                         │
│  页面内容（单栏）        │
│                         │
├─────────────────────────┤
│ 卡片 | 提醒 | 贵宾厅 | 我的 │  ← 底栏固定
└─────────────────────────┘
```

### Tab 定义

| Tab | 路由 | 说明 |
|-----|------|------|
| 卡片 | `/dashboard` | 我的卡列表 + 推荐卡 |
| 提醒 | `/dashboard#reminders` | 同页锚点，滚动到 30 天提醒 |
| 贵宾厅 | `/lounges` | 机场贵宾厅查询 |
| 我的 | `/me` | 通知偏好与账号 |

未登录：不显示底栏，首页 / 登录页单独做营销式移动布局。

## 断点

- **App 壳生效**：`max-width: 767px`（`md` 以下）
- **桌面布局**：`768px+` 继续用现有顶栏与多栏

实现上用 CSS 类 `app-shell` + `@media (max-width: 767px)`，避免影响桌面。

## 实现路径（分阶段）

### P0 — 壳与核心页（当前）

1. `MobileBottomNav.svelte` 底栏组件
2. `app.css` 增加 app-shell / safe-area / 底栏样式
3. `app.html` 补 viewport-fit、theme-color、apple-mobile-web-app
4. 接入：`/dashboard`、`/me`（卡片 / 我的）
5. 文档落盘 `docs/design/*`

### P1 — 全链路 App 化

1. `/cards/add`、`/cards/[id]/edit` 使用壳（隐藏底栏或保留「卡片」高亮）
2. `/lounges` 接入底栏
3. 首页手机端：更强 CTA、更少装饰动画、接近 Vellet 长页节奏
4. 「添加到主屏幕」轻提示（可选）

### P2 — 体验打磨

1. 路由切换过渡（轻 fade）
2. 下拉刷新感 / 骨架屏
3. ~~manifest + icons 真 PWA（可选）~~ ✅ 已落地（`static/manifest.webmanifest` + `static/sw.js` + `PwaInstall`）
4. 手势返回与表单全屏

## PWA 安装说明

- **Android Chrome**：打开站点 → 浏览器菜单「安装应用」或底部安装条
- **iOS Safari**：分享 →「添加到主屏幕」
- 安装后以 `standalone` 全屏打开，默认进 `/dashboard`
- 相关文件：
  - `static/manifest.webmanifest`
  - `static/sw.js`
  - `static/icons/icon-192.png` / `icon-512.png`
  - `src/lib/components/PwaInstall.svelte`
  - `src/lib/pwa.ts`

## 代码落点

```
docs/design/                 # 设计说明（本目录）
src/lib/components/
  MobileBottomNav.svelte     # 底栏
src/app.css                  # .app-shell / .app-tabbar / safe-area
src/app.html                 # viewport / theme-color
src/routes/dashboard/        # 主 App 页
src/routes/me/               # 我的
src/routes/lounges/          # 贵宾厅（P1）
src/routes/cards/            # 加卡 / 编辑（P1）
```

## 不做的事（避免跑偏）

- 不单独做一套「另一品牌」的浅色 UI
- 不把桌面顶栏改成汉堡菜单凑合（应用底栏）
- 不强制用户安装 PWA 才能用
- 不拆成独立 mobile 域名（同一套 SvelteKit 响应式）

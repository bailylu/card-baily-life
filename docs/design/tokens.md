# 设计 Token

与 `src/app.css` 的 `:root` 保持同步。改色先改 CSS 变量，再回写本文档。

## 颜色

| Token | 值 | 用途 |
|-------|-----|------|
| `--bls-bg-void` | `#06090f` | 最深背景 |
| `--bls-bg` | `#0a0e18` | 页面底 |
| `--bls-panel` | `#121829` | 卡片 / 面板 |
| `--bls-panel-2` | `#19223a` | 次级面板 |
| `--bls-inset` | `#0c111e` | 内嵌区域 |
| `--bls-ink` | `#ecf1fb` | 主文字 |
| `--bls-body` | `#c2cce0` | 正文 |
| `--bls-muted` | `#828fab` | 次要说明 |
| `--bls-gold` / `--bls-gold-bright` | `#e8b53d` / `#ffda7b` | 主 CTA、强调 |
| `--bls-cyan` | `#2fe6d4` | 链接、激活态 |
| `--bls-blue` | `#5b9dff` | 氛围光 |
| `--bls-green` | `#4df08a` | 成功 |
| `--bls-red` | `#ff5a5a` | 危险 / 退出 |

## 移动端专用

| Token | 建议值 | 用途 |
|-------|--------|------|
| `--app-tabbar-h` | `64px` | 底栏内容高度（不含 safe-area） |
| `--app-topbar-h` | `56px` | 移动顶栏高度 |
| `--app-safe-bottom` | `env(safe-area-inset-bottom, 0px)` | 底部安全区 |
| `--app-safe-top` | `env(safe-area-inset-top, 0px)` | 顶部安全区 |
| `--app-touch-min` | `44px` | 最小点击高度 |

## 圆角与阴影

- 面板圆角：约 `6px`（硬边信用卡风，不是大圆角消费 App）
- 卡面图片可更圆（`rounded-xl`）以贴近实体卡
- 阴影：偏「硬偏移」`4px 4px 0`，保持现有 bls 风格

## 字体

```
"Noto Sans SC", -apple-system, BlinkMacSystemFont, "PingFang SC", "Microsoft YaHei", sans-serif
```

标签 / 英文小字：`ui-monospace` + 大写 tracking（`.bls-label`）。

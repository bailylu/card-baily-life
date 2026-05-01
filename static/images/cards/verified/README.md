# Verified card images

这个目录只放人工确认过的正式卡面图。

## 接入规则

- 图片可以是官网展示图，但必须能明确识别银行和卡种。
- 不放二维码、宣传海报、Logo、新闻配图、截图拼图或不相关图片。
- 建议使用接近信用卡比例 `1.586:1` 的横向图片。
- 推荐格式：`.jpg`、`.png`、`.webp`。
- 文件名使用稳定英文/拼音 slug，例如 `cmb-classic-platinum.jpg`。

## 接入流程

1. 把正确图片放到这个目录。
2. 在 `docs/card-image-verified.csv` 中把对应行的 `image_file` 填成文件名。
3. 把 `status` 从 `missing` 改为 `verified`。
4. 生成并执行图片映射迁移后，前端才会展示真实卡面。

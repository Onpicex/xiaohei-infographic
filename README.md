[English](README.en.md) · **中文**

# 小黑信息图

把文章、笔记、推文、提纲或任何结构化内容,整理成小黑风格的中文信息图 / 知识卡片。

本 skill 是两个项目的**合成体**:信息架构 + 渲染管线取自一个 infographic skill,视觉语言取自 Ian 的小黑插画。

- **文字全部由 HTML/CSS 承载** —— 标题、核心论点、每节要点、手写批注、收尾。文字永远清晰,绝不出现错别字。
- **小黑场景由 `image_gen` 生成** —— 每节生成一张真正手绘的小黑隐喻图,**纯白底、不含任何文字**,再合成进该节的图槽。
- **Playwright** 把合成后的页面截成高清 PNG。

默认产物是一张可分享长图:纯白底、无框并排流(每节插图 + 文字、左右交替),不是 PPT 卡片网格。

> ⚠️ **本 skill 会生成图片,不是纯文本/HTML。**
> - **需要图片生成模型。** 运行的 agent 必须具备 `image_gen`(或等价)工具。没有的话只能走*纯代码 fallback*,那只能画出图标级小黑,没有手绘质感。
> - **耗时较久。** 每节生成一张图(通常 3–5 次调用),外加 Playwright 渲染。会明显慢于纯文字信息图,并消耗生图额度/成本。请预留时间,QA 阶段重生成时尤其如此。
> - **要为迭代留余量。** 生成的场景有时需要回炉重生(小黑太装饰、混进文字、隐喻跑偏),会再增加调用次数。

## 产物

- 一张自包含的 `1080px` 宽 HTML 页面,渲染成高清 PNG(3 倍 → 约 3240px 宽)。
- 适合微信、X/Twitter、Telegram、博客、笔记的中文视觉摘要。
- 每节一张小黑隐喻场景,小黑亲自完成那一节的核心动作,而不是当装饰吉祥物。

## 用法

典型指令:

```text
把这篇文章整理成适合手机阅读的中文小黑信息图:https://example.com/article
```

skill 会:

1. 抽取标题、核心论点、3–5 个分节、收尾结论、来源。
2. 为每节重新发明一个小黑动作隐喻。
3. 用 `image_gen` 把每个隐喻生成为纯白底、无文字的图。
4. 填入 `templates/composite-flow.html`,把图槽指向生成的场景,补上 HTML 批注。
5. 渲染高清 PNG,跑 QA 门禁,直到干净且手机可读。

另有**纯代码 fallback**(内联 SVG 小黑,不调 `image_gen`),用于零成本 / 完全可复现的场景 —— 但只能得到图标级小黑,没有手绘质感。

## 渲染

```bash
node scripts/screenshot.js working.html output.png 3 1080
python3 -c "from PIL import Image;w,h=Image.open('output.png').size;print(f'{w}x{h} 1:{h/w:.2f}')"  # 目标 1:1.4–1.9
```

`screenshot.js` 优先用 Playwright;macOS 上若没有内置 Chromium,会回退到系统的 Google Chrome。

## 目录结构

```text
xiaohei-infographic/
├── SKILL.md
├── README.md                       # 中文(默认)
├── README.en.md                    # English
├── templates/
│   └── composite-flow.html         # 默认脚手架 —— 从这里开始
├── references/
│   ├── image-gen-prompt.md         # 纯白底无字小黑提示词 + 造隐喻法
│   ├── xiaohei-infographic-design.md
│   ├── html-patterns.md
│   ├── x-article-extraction.md
│   └── qa-gate.md                  # 强制后置 QA 门禁
├── scripts/
│   ├── screenshot.js
│   └── send_telegram.sh            # Telegram 无损投递(sendDocument)
└── outputs/                        # 持久化渲染产物
```

## 致谢

本 skill 是两个既有项目的**合成**,在此整合为一个混合版(生成小黑场景 + HTML 承载文字)。完整归功并感谢原作者:

- **小黑视觉语言与 IP** —— [helloianneo/ian-xiaohei-illustrations](https://github.com/helloianneo/ian-xiaohei-illustrations):小黑角色、风格 DNA、造隐喻法、反复刻规则。
- **信息图结构与渲染管线** —— [jincai/openclaw-skills · infographic](https://github.com/jincai/openclaw-skills/tree/main/infographic):信息架构、HTML + Playwright 截图方案、移动端卡片可读性、Telegram 无损投递。

本仓库只贡献了*合成*这一层:把每节的小黑路由到 `image_gen`(纯白底、无文字),再合成进一张文字保持清晰的无框流。如果你只想要其中一部分 —— 独立的文章配图,或一张普通信息图 —— 请直接使用上游项目。

## 许可

MIT License,详见 [LICENSE](LICENSE)。

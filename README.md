# Xiaohei Infographic

Create Xiaohei-style Chinese infographics and knowledge cards from articles, notes, tweets, outlines, or structured content.

This Codex skill combines a clear infographic structure with Ian-style Xiaohei visual language: pure white background, black hand-drawn metaphor scenes, sparse red/orange/blue handwritten notes, and mobile-friendly information hierarchy.

## What It Produces

- Self-contained `750px` wide HTML long images.
- High-DPI PNG screenshots, usually rendered at `3x`.
- Chinese visual summaries for WeChat, X/Twitter, Telegram, blogs, and notes.
- Section-level Xiaohei metaphor drawings where Xiaohei performs the conceptual action, instead of acting as a decorative mascot.

## Install

Copy this repository into your Codex skills directory:

```bash
mkdir -p ~/.codex/skills
git clone https://github.com/Onpicex/xiaohei-infographic.git ~/.codex/skills/xiaohei-infographic
```

Then invoke it in Codex:

```text
$xiaohei-infographic 将这篇文章整理成信息图 <URL>
```

## Usage

Typical prompt:

```text
$xiaohei-infographic 把这篇文章整理成适合手机阅读的中文信息图：https://example.com/article
```

The skill asks Codex to:

1. Extract the title, thesis, 3-7 sections, takeaway, and source.
2. Convert each section into a small Xiaohei action metaphor.
3. Build a self-contained HTML poster.
4. Render a high-DPI PNG with the bundled screenshot script.
5. Inspect and iterate until the output is readable and visually clean.

## Render

The skill includes a screenshot helper:

```bash
node scripts/screenshot.js input.html output.png 3 750
```

It uses Playwright when available. If the bundled Playwright browser is missing on macOS, it attempts to fall back to system Google Chrome.

## Repository Layout

```text
xiaohei-infographic/
├── SKILL.md
├── agents/
│   └── openai.yaml
├── references/
│   ├── html-patterns.md
│   └── xiaohei-infographic-design.md
└── scripts/
    └── screenshot.js
```

## License

MIT

**English** · [中文](README.md)

# Xiaohei Infographic

Create Xiaohei-style Chinese infographics and knowledge cards from articles, notes, tweets, outlines, or any structured content.

This skill is a **hybrid** of two parents: it borrows the *information architecture + render pipeline* from an infographic skill, and the *visual language* from Ian's Xiaohei illustrations.

- **HTML/CSS owns all text** — title, thesis, section points, handwritten annotations, takeaway. Text is always crisp, never mis-spelled.
- **`image_gen` owns the Xiaohei scenes** — each section gets a real hand-drawn Xiaohei metaphor, generated **text-free on a pure-white background**, then composited into the section's image slot.
- **Playwright** screenshots the composed page to a high-DPI PNG.

The default output is ONE shareable long image: pure white, frameless side-by-side flow (illustration + text per section, alternating sides), no PPT card grid.

> ⚠️ **This skill generates images — it is not pure text/HTML.**
> - **It requires an image-generation model.** The running agent must have an `image_gen` tool (or equivalent). Without one, only the *pure-code fallback* works, and that produces icon-grade Xiaohei, not the hand-drawn look.
> - **It is slow.** One image is generated **per section** (typically 3–5 calls), plus the Playwright render. Expect this to take noticeably longer than a text-only infographic, and to consume image-generation quota/cost. Budget time accordingly, especially if you regenerate sections during QA.
> - **Plan for iteration.** Generated scenes sometimes need a re-roll (Xiaohei too decorative, stray text, off-metaphor), which adds more generation calls.

## What It Produces

- A self-contained `1080px`-wide HTML page rendered to a high-DPI PNG (3x → ~3240px wide).
- Chinese visual summaries for WeChat, X/Twitter, Telegram, blogs, and notes.
- Per-section Xiaohei metaphor scenes where Xiaohei performs the conceptual action, instead of acting as a decorative mascot.

## Usage

Typical prompt:

```text
Turn this article into a mobile-friendly Xiaohei-style infographic: https://example.com/article
```

The skill will:

1. Extract the title, thesis, 3–5 sections, takeaway, and source.
2. Invent a fresh Xiaohei action metaphor for each section.
3. Generate each metaphor as a text-free, white-background image with `image_gen`.
4. Fill `templates/composite-flow.html`, point the image slots at the generated scenes, add HTML annotations.
5. Render a high-DPI PNG and run the QA gate until it's clean and phone-legible.

A **pure-code fallback** (inline SVG Xiaohei, no `image_gen`) exists for zero-cost / fully-reproducible runs — it yields icon-grade Xiaohei rather than the hand-drawn look.

## Render

```bash
node scripts/screenshot.js working.html output.png 3 1080
python3 -c "from PIL import Image;w,h=Image.open('output.png').size;print(f'{w}x{h} 1:{h/w:.2f}')"  # target 1:1.4–1.9
```

`screenshot.js` uses Playwright when available, and falls back to system Google Chrome on macOS if no bundled Chromium is installed.

## Repository Layout

```text
xiaohei-infographic/
├── SKILL.md
├── README.md                       # Chinese (default)
├── README.en.md                    # English
├── templates/
│   └── composite-flow.html         # default scaffold — start here
├── references/
│   ├── image-gen-prompt.md         # text-free white-bg Xiaohei prompt + metaphor method
│   ├── xiaohei-infographic-design.md
│   ├── html-patterns.md
│   ├── x-article-extraction.md
│   └── qa-gate.md                  # mandatory post-render gate
├── scripts/
│   ├── screenshot.js
│   └── send_telegram.sh            # lossless Telegram delivery (sendDocument)
└── outputs/                        # durable renders
```

## Credits

This skill is a **synthesis of two existing projects**, combined here into a single hybrid (generated Xiaohei scenes + HTML-owned text). Full credit and thanks to their authors:

- **Xiaohei visual language & IP** — [helloianneo/ian-xiaohei-illustrations](https://github.com/helloianneo/ian-xiaohei-illustrations): the Xiaohei character, style DNA, metaphor-invention method, and anti-copy rules.
- **Infographic structure & render pipeline** — [jincai/openclaw-skills · infographic](https://github.com/jincai/openclaw-skills/tree/main/infographic): the information architecture, the HTML + Playwright screenshot approach, mobile-card readability, and lossless Telegram delivery.

This repo only contributes the *combination*: routing each section's Xiaohei to `image_gen` (text-free, white background) and compositing it into a frameless flow whose text stays crisp. If you want the parts on their own — standalone article illustrations, or a plain infographic — use the upstream projects directly.

## License

MIT License. See [LICENSE](LICENSE).

---
name: xiaohei-infographic
description: "Create Xiaohei-style Chinese infographics and knowledge cards from articles, notes, tweets, outlines, or structured content. Use when the user asks for 信息图, 知识卡片, 长图, visual summary, shareable image, WeChat/social media card, or wants to combine Ian 小黑 hand-drawn illustration style with infographic structure. Produces one high-DPI PNG shareable long image: pure white background, real hand-drawn Xiaohei metaphor scenes generated per section with image_gen (text-free, white background), composited into a frameless HTML flow whose text and handwritten annotations stay crisp, then screenshotted with Playwright."
---

# Xiaohei Infographic

## Sibling Skill — Don't Confuse Them

`ian-xiaohei-illustrations` is a *different* skill: it generates standalone 16:9 小黑 body illustrations (one `image_gen` image per concept, dropped into an article between paragraphs). THIS skill produces ONE composited long image / 知识卡片 / 长图 with HTML-owned text plus per-section 小黑 scenes screenshotted together. Rule of thumb: **article body illustrations → `ian-xiaohei-illustrations`; shareable infographic / knowledge card → `xiaohei-infographic`.** The 小黑 visual DNA and anti-copy rules are shared; this skill's `references/image-gen-prompt.md` reuses the same metaphor-invention method.

## Core Idea

Turn structured content into ONE shareable Chinese long image whose **information architecture** comes from an infographic, but whose **visual language** comes from Ian 小黑: pure white, hand-drawn, sparse, deadpan, slightly absurd, built around Xiaohei performing the key conceptual work of each section.

This is a **hybrid** skill. The split is deliberate:

- **HTML/CSS owns all text** — title, thesis, section points, handwritten-style annotations, takeaway, footer. Text is therefore always crisp and never mis-spelled.
- **`image_gen` owns the Xiaohei scenes** — each section gets a real hand-drawn 小黑 metaphor image, generated **text-free on a pure-white background**, then dropped into the section's image slot. White-on-white means it composites seamlessly.
- **Playwright composites and screenshots** the whole page to a high-DPI PNG.

Do not make a normal polished PPT infographic with a mascot pasted on it, and do not fall back to bordered card grids — that drift toward "PPT" is the #1 failure mode. Every section is an unframed row where Xiaohei does the action that explains the point, with the text beside it.

> **Why generate the 小黑 instead of drawing it in SVG/CSS?** Hand-coded SVG can only produce a stiff generic blob — it cannot invent a fresh absurd metaphor per section, which is the soul of the style. So the default routes the illustration to `image_gen`. A pure-code fallback exists (see "Fallback") but produces icon-grade Xiaohei, not Ian-grade.

## Read As Needed

- `templates/composite-flow.html`: **start here by default** — known-good 1080px-wide, frameless side-by-side flow scaffold (header → thesis → alternating illustration+text sections → dark takeaway → footer). It is fully populated with a worked example; copy it, then swap content and the `<img>` paths.
- `references/image-gen-prompt.md`: the text-free, white-background 小黑 generation prompt template + the 3-step metaphor-invention method and anti-copy rule. Read before generating any image.
- `references/xiaohei-infographic-design.md`: visual DNA, frameless-flow layout rules, color, typography, mobile legibility, the remove-Xiaohei test, anti-PPT rules.
- `references/html-patterns.md`: the 1080px frameless-flow CSS/HTML fragments (image slot + annotation overlay).
- `references/qa-gate.md`: **mandatory** post-render gate. Run it before delivery.
- `references/x-article-extraction.md`: how to get the real full text of an X (Twitter) Article before summarizing.
- `scripts/screenshot.js`: render HTML → high-DPI PNG (Playwright; falls back to system Google Chrome on macOS when no bundled Chromium).
- `scripts/send_telegram.sh`: lossless Telegram delivery via `sendDocument`.

## Workflow

### 1. Extract the content

When the source is an X (Twitter) post, get the REAL full text before summarizing — do not infographic a preview. See `references/x-article-extraction.md`. Label content as preview-level only when full text is genuinely unavailable.

Identify:

- **Title**: Chinese primary, optional English/orange accent fragment.
- **Core thesis**: 1 short callout.
- **Main sections**: aim for **3–5** (single-page flow gets too tall past 5 — trim, merge, or split into a second image).
- **Bottom takeaway**: one concise conclusion or action.
- **Source attribution**: author, platform, URL, date when available.

Keep text scannable: section title + 1–3 short points. If the source is long, prefer splitting into 2 images over making one dense poster.

### 2. Invent a fresh Xiaohei metaphor per section

For each section, convert the abstract point into one physical action (extract, filter, weigh, stitch, route, compress, sort, open, block, repair, catch, recycle), then put Xiaohei *inside* that action using 1–2 simple low-tech props (box, funnel, scale, drawer, gate, pipe, black box, ladder, line ball, stamp, dial, strange workstation).

Invent a new metaphor from THIS article every time. Do **not** reuse known Ian compositions (conveyor breakpoints, 小黑 pulling a judgment lever, funnel sorting, cutting the material-fish, etc.) unless the user explicitly asks to copy a reference. See `references/image-gen-prompt.md` for the 3-step method.

Test: if removing Xiaohei would leave the section fully intact, the metaphor is decorative — redesign it.

### 3. Generate the Xiaohei scenes with `image_gen`

For each section, call `image_gen` once with a prompt built from `references/image-gen-prompt.md`. Non-negotiables baked into every prompt:

- **Pure white background** (so it composites seamlessly into the white page).
- **Absolutely no text / letters / Chinese characters anywhere in the image** — HTML owns all text. This also means you never re-generate just to fix wording.
- **Xiaohei performs the core action** (not standing in a corner), with a consistent identity: small solid-black uneven body, white dot eyes, thin legs, blank serious expression.
- Roughly **3:2**, single clear metaphor, lots of white space.

Save the images to `assets/<article-slug>/01.png`, `02.png`, … (one per section, in order). Do not overwrite prior runs' assets.

### 4. Build the HTML from the template

Copy `templates/composite-flow.html` to a working file. Then:

- Fill header (eyebrow, `h1` with one orange `.accent` fragment, subtitle/source), thesis, each section's `h2` + points, takeaway, footer.
- Point each section's `<img src>` at the `assets/<slug>/NN.png` you just generated.
- Add **1–2 short handwritten-style annotations per section** as `.note` overlays (red = problem/result, orange = main path, blue = secondary). Position them at the image's edges via inline `left/right/top/bottom`. Keep them 2–8 characters.
- Odd sections: illustration on the left. Even sections: add class `flip` (illustration on the right). Alternation gives rhythm and avoids a grid feel.

Keep it self-contained: no external dependencies, no CDN fonts, no fixed page height.

### 5. Render PNG

```bash
node scripts/screenshot.js working.html output.png 3 1080
```

Output should be ~3240px wide at 3x. Then check the aspect ratio:

```bash
python3 -c "from PIL import Image;w,h=Image.open('output.png').size;print(f'{w}x{h} 1:{h/w:.2f}')"
```

Target **1:1.4 – 1:1.9** (height/width). If > 1.9: trim a section, tighten vertical gaps, or move to a second image. Do not fix tallness by shrinking width.

**5 sections almost always overshoots to ~1:1.9–1:1.95.** Don't panic-trim content — pull it back by tightening vertical rhythm only. Concrete knobs that took a 1:1.94 build down to 1:1.79 without touching width or cutting a section: `.wrap` gap 30→22px, `body` top/bottom padding 48/40→36/30px, `.section` gap 46→42px, `.points li` line-height 1.5→1.45 + margin-bottom 6→5px, `.takeaway` padding 30/34→26/32px + font 25→24px. Re-render and re-check the ratio.

### 6. QA gate and iterate

Run `references/qa-gate.md` against the rendered PNG. **Honesty about what you can actually verify:** you can machine-check geometry and pixels (corners white, ink %, dimensions, ratio) but you generally CANNOT visually parse the *semantics* of a generated scene — there is no vision/`vision_analyze` tool, and `browser_navigate` on a bare PNG returns an empty snapshot (it only reads DOM). So do NOT claim "I inspected the image and it's fine." Instead: (a) run the machine checks below, (b) build a stacked contact sheet of all section PNGs and send it to the user, (c) tell them plainly you verified the machine metrics but the final semantic judgment (是不是真在做动作 / 有没有混进文字) is theirs, and offer to regenerate any single numbered scene without touching the others. The user is the vision check — design the loop around that, don't fake it.

Run the PIL machine checks with the **system `python3`** (it has Pillow). The `execute_code` sandbox does NOT have PIL — `from PIL import Image` raises ModuleNotFoundError there; shell out to `python3` via terminal instead, or `uv run --with pillow python3`.

Regenerate the offending scene or edit the HTML if any gate fails (PPT/grid look, Xiaohei decorative, beige/textured background, illegible on phone, aspect > 1.9, too many annotations/colors, baked-in text in a generated scene).

## Fallback: pure-code mode (no image_gen)

If the user needs **zero image-gen cost, fully deterministic/reproducible output, or per-character editability**, draw Xiaohei with inline SVG/CSS in the image slot instead of generating it. Be honest with the user that this mode yields **icon-grade** Xiaohei, not the hand-drawn Ian look — the metaphors will be stiffer and more generic. Everything else (layout, text, annotations, render, QA) is identical. Default to the `image_gen` path unless the user opts into this.

## Delivery

Return:

- The PNG path.
- The HTML path (useful for later edits).
- The `assets/<slug>/` path with the generated scenes.
- A one-line note about the content structure.

Save durable outputs in `outputs/`.

### Telegram delivery — send as a FILE, not a photo

Telegram's photo path (`sendPhoto`) compresses and downscales (longest side ~2048px), turning a tall text-heavy image into a blurry strip even when the source is 3240px and crisp. This is a Telegram property, not an image-quality problem. If the user says "模糊 / 看不清晰 / 不清楚", do NOT just re-render at higher resolution.

Fix, in order:

1. **Send as a document/file** to bypass photo compression: `bash scripts/send_telegram.sh output.png "Caption"`. (Or convert to a single-page PDF — `Image.save('out.pdf','PDF',resolution=144)` — and send that.)
2. If the user wants it readable *inline* without tapping, split into 2–3 shorter images so each one's long side survives downscaling.

Run machine QA on the rendered PNG before declaring done (corners white, ink %, dimensions, ratio via system `python3` + PIL), then send a contact sheet for the human to make the final semantic call — don't assert you visually inspected scene content you can't actually parse with tools.

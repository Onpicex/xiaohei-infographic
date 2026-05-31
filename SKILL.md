---
name: xiaohei-infographic
description: Create Xiaohei-style Chinese infographics and knowledge cards from articles, notes, tweets, outlines, or structured content. Use when the user asks for 信息图, 知识卡片, 长图, visual summary, shareable image, WeChat/social media card, or wants to combine Ian 小黑 hand-drawn illustration style with infographic structure. Produces high-DPI PNG via self-contained HTML plus Playwright screenshots, with pure white background, black hand-drawn Xiaohei metaphors, sparse red/orange/blue handwritten Chinese annotations, and mobile-friendly information hierarchy.
---

# Xiaohei Infographic

## Core Idea

Turn structured content into a shareable Chinese infographic whose information architecture comes from an infographic, but whose visual language comes from Ian 小黑: pure white, hand-drawn, sparse, deadpan, slightly absurd, and built around Xiaohei performing the key conceptual work.

Do not make a normal polished PPT infographic with a mascot pasted on it. Every major section should have a small hand-drawn metaphor where Xiaohei does the action that explains the point.

## Read As Needed

- `references/xiaohei-infographic-design.md`: visual rules, layout rules, Xiaohei behavior, QA.
- `references/html-patterns.md`: self-contained HTML/CSS patterns for the long image.
- `scripts/screenshot.js`: render the HTML to a high-DPI PNG.

## Workflow

### 1. Extract the content

Identify:

- Title: Chinese primary, optional English subtitle.
- Core thesis: 1 short callout.
- Main sections: 3-7 sections, each with 1-3 short points.
- Bottom takeaway: one concise conclusion or action.
- Source attribution: author, platform, URL, date when available.

Keep text scannable. If the source is long, split into multiple images instead of making one dense poster.

### 2. Invent Xiaohei metaphors

For each section, convert the abstract point into one physical action:

- extract, filter, weigh, stitch, route, compress, sort, open, block, repair, catch, recycle.

Then assign Xiaohei the action:

- Xiaohei pulls the route, guards the gate, pushes the lever, gets stuck in the filter, weighs a decision, stitches two boxes, catches falling notes, or feeds a strange machine.

Use 1-2 simple objects per section: box, funnel, scale, drawer, gate, pipe, black box, ladder, line ball, stamp, dial, strange workstation.

Avoid reusing known Ian compositions unless the user explicitly asks to copy a reference.

### 3. Build self-contained HTML

Use one `750px` wide HTML page. No external dependencies, no CDN fonts, no fixed height. Render the `body` screenshot at `3x`.

Default visual direction:

- Background: pure white or near-white (`#fffefb`), not cream paper.
- Main drawing: black hand-drawn CSS/SVG line art.
- Color accents: orange for main paths, red for warnings/results, blue for secondary notes.
- Typography: Chinese system font stack; use hand-note classes sparingly.
- Layout: header, thesis callout, section blocks, dark or ink-heavy takeaway, footer.

Draw Xiaohei and simple objects with inline SVG or CSS. Keep them rough and minimal; avoid polished vector icons, emoji, stock illustrations, gradients, shadows, and decorative blobs.

### 4. Render PNG

Save the HTML near the output or in a scratch directory, then run:

```bash
node path/to/xiaohei-infographic/scripts/screenshot.js input.html output.png 3 750
```

The output should be `2250px` wide at `3x`.

### 5. QA and iterate

Before delivery, inspect the PNG. Fix and re-render if:

- It looks like a PPT deck, dashboard, course slide, or formal flowchart.
- Xiaohei is decorative rather than doing the explanatory action.
- The page is too dense to scan on a phone.
- The background is beige/gradient/textured instead of clean white.
- There are too many borders, cards, shadows, icons, colors, or paragraphs.
- Chinese labels are long, tiny, or repetitive.
- A section would still communicate fully if Xiaohei were removed.

## Delivery

Return:

- The PNG path.
- The HTML path when useful for later editing.
- A one-line note about the content structure.

When saving durable outputs in this workspace, use the `outputs/` directory.

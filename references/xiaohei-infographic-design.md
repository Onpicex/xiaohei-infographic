# Xiaohei Infographic Design

## Visual DNA

Pure white, black hand-drawn line work, large quiet areas, compact Chinese text, sparse red/orange/blue handwritten notes, and one deadpan black Xiaohei doing the section's conceptual labor.

The result should feel like a sharp visual summary drawn on a whiteboard by a product-minded person, not a marketing poster or PPT infographic.

## Page Rules

- Width: `750px`; screenshot at `3x`.
- Height: content-driven; do not use fixed page height.
- Background: `#fffefb` or `#ffffff`; avoid cream, gradients, paper texture, shadows, and noise.
- Outer padding: `40-48px` top/bottom, `36-42px` sides.
- Use a clear vertical sequence: header -> thesis -> sections -> takeaway -> footer.
- Favor full-width bands and unframed layouts. Use cards only for repeated section blocks, and keep radius at `8px` or less.
- Keep at least 25-35% visible white space across the image.

## Color

- Ink: `#171717` for Xiaohei, line art, headings.
- Body text: `#333333`.
- Muted text: `#76716b`.
- Paper line: `#e8e2d8`.
- Orange: `#e8752e` for main flow/path/arrows.
- Red: `#d83a2e` for warnings, friction, final results.
- Blue: `#2f73d9` for secondary notes, system feedback, AI/tool hints.
- Dark takeaway: `#171717` with text `#f8f3ea`.

Use one dominant accent per section. Do not distribute colors evenly just to decorate.

## Typography

Use:

```css
font-family: -apple-system, BlinkMacSystemFont, "PingFang SC", "Noto Sans SC", "Helvetica Neue", Arial, sans-serif;
```

Suggested scale:

- Main title: `30-34px`, weight `900`, line-height `1.15`.
- Subtitle/source: `12-14px`, weight `500`, line-height `1.45`.
- Thesis: `18-21px`, weight `800`, line-height `1.45`.
- Section title: `18-20px`, weight `850`, line-height `1.25`.
- Body: `14-15px`, line-height `1.65`.
- Handwritten note: `12-13px`, weight `700`, line-height `1.25`.

Keep Chinese labels short: usually 2-8 characters.

## Xiaohei

Xiaohei is a small solid-black absurd worker:

- Black uneven blob/body, white dot eyes, thin legs, optional thin arms.
- Blank serious expression. Not cute, not mascot-like.
- Must perform the core action: pull, push, weigh, stitch, sort, block, repair, catch, feed, record.
- Should be embedded in the section metaphor, not standing in the margin.

Test: if removing Xiaohei leaves the section fully intact, redesign the metaphor.

## Section Pattern

Each section should include:

- A short section title.
- One Xiaohei visual metaphor.
- 1-3 concise points.
- 1-2 handwritten labels or arrows.

Good section metaphors:

- "filtering noisy inputs" -> Xiaohei stuck inside a funnel, catching only two notes.
- "strategy chooses constraints" -> Xiaohei weighing two blocks on a scale.
- "workflow handoff" -> Xiaohei stitching two boxes with an orange thread.
- "bad metric" -> Xiaohei guarding a gate while red scraps pile up outside.
- "iteration loop" -> Xiaohei turning a crank on a small loop machine.

## Avoid

- Polished vector illustration.
- Formal architecture diagrams.
- Dense node-link maps.
- Hero gradients, decorative orbs, bokeh, neon, glassmorphism.
- Emoji icons.
- Big rounded pills full of text.
- Large blocks of body copy.
- Multiple nested cards.
- Xiaohei as a corner sticker.

## QA

Pass criteria:

- The top thesis is readable in one glance.
- Each section has one clear idea and one weird physical action.
- Xiaohei is doing meaningful work in every major section.
- The image remains legible at phone size.
- The style is sparse, hand-drawn, and clean.

Regenerate or edit if the first impression is "template infographic" rather than "strange clear whiteboard sketch."

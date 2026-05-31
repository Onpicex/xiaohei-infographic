# HTML Patterns (frameless flow, 1080px)

The full known-good scaffold is `templates/composite-flow.html` — **start there**. These fragments explain the moving parts so you can adapt it. Keep the file self-contained (no CDN, no external fonts, no fixed page height).

## Base shell

```html
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="UTF-8" />
<style>
* { box-sizing: border-box; margin: 0; padding: 0; }
:root {
  --ink:#171717; --body:#333; --muted:#76716b; --line:#e8e2d8;
  --orange:#e8752e; --red:#d83a2e; --blue:#2f73d9; --paper:#fffefb;
}
body {
  width: 1080px;
  padding: 44px 72px 40px;
  background: var(--paper);
  color: var(--ink);
  font-family: -apple-system, BlinkMacSystemFont, "PingFang SC", "Noto Sans SC", "Helvetica Neue", Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
}
.hand { font-family: "Xingkai SC", "Kaiti SC", "STKaiti", cursive; }
.wrap { display: flex; flex-direction: column; gap: 30px; }
</style>
</head>
<body><main class="wrap"><!-- header / thesis / sections / takeaway / footer --></main></body>
</html>
```

## Header + thesis

```html
<header>
  <span class="eyebrow">分类 · 标签</span>
  <h1>中文主标题:<span class="accent">橙色重点片段</span></h1>
  <p class="subtitle">副标题 / 来源</p>
  <div class="rule"></div>
</header>

<p class="thesis">核心一句话,左侧橙色竖条,不做成填充卡片。</p>
```

```css
.eyebrow { align-self:flex-start; border:2px solid var(--ink); border-radius:999px; padding:6px 16px 5px; font-size:18px; font-weight:800; }
h1 { margin-top:14px; font-size:50px; line-height:1.14; font-weight:900; letter-spacing:-.5px; }
h1 .accent { color:var(--orange); }
.subtitle { margin-top:12px; color:var(--muted); font-size:21px; line-height:1.5; }
.rule { height:3px; background:var(--ink); margin-top:22px; }
.thesis { border-left:6px solid var(--orange); padding:6px 0 6px 22px; font-size:30px; line-height:1.5; font-weight:800; }
```

## Section: frameless side-by-side row (the core pattern)

Odd sections: illustration left. Even sections: add class `flip` → illustration right. **No border on the row.**

```html
<section class="section">
  <div class="shot">
    <img src="../assets/<slug>/01.png" alt="小黑在做核心动作" />
    <span class="note orange" style="left:2%; top:6%;">拆开 →</span>
  </div>
  <div class="body">
    <h2><span class="n">01</span>这一节的短标题</h2>
    <ul class="points">
      <li>一句要点。</li>
      <li>再一句要点。</li>
    </ul>
  </div>
</section>

<section class="section flip"> … 图在右 … </section>
```

```css
.section { display:flex; align-items:center; gap:48px; }
.section.flip { flex-direction:row-reverse; }

/* 图槽:白底无缝,固定 3:2,contain 让任意生成图不变形、不留可见边框 */
.shot { position:relative; flex:0 0 38%; }
.shot img { display:block; width:100%; aspect-ratio:3/2; object-fit:contain; background:var(--paper); }

/* 批注 overlay:绝对定位在图四周,文字清晰可控(不要把字画进生成图里) */
.note { position:absolute; font-size:22px; font-weight:700; line-height:1.2; white-space:nowrap; }
.note.red { color:var(--red); } .note.orange { color:var(--orange); } .note.blue { color:var(--blue); }

.body { flex:1; }
.body h2 { font-size:34px; line-height:1.25; font-weight:900; margin-bottom:14px; }
.body h2 .n { color:var(--orange); margin-right:10px; }
.points { list-style:none; }
.points li { position:relative; padding-left:26px; font-size:22px; line-height:1.5; color:var(--body); margin-bottom:6px; }
.points li::before { content:""; position:absolute; left:4px; top:14px; width:9px; height:9px; background:var(--ink); border-radius:2px; }
```

**Annotation positioning:** set one of `left/right` + one of `top/bottom` inline as percentages so the note sits just outside or at the corner of the scene. 1–2 per section, 2–8 characters each. Optionally add `.hand` for a handwritten look.

## Takeaway + footer

```html
<p class="takeaway">收尾结论,<b>关键词</b>用金色强调。</p>
<footer class="footer">
  <span>来源:作者 / 平台 / URL / 日期</span>
  <span>xiaohei-infographic · 小黑信息图</span>
</footer>
```

```css
.takeaway { background:var(--ink); color:#f8f3ea; border-radius:10px; padding:30px 34px; font-size:26px; line-height:1.5; font-weight:700; }
.takeaway b { color:#ffbf58; }
.footer { display:flex; justify-content:space-between; gap:24px; color:var(--muted); font-size:16px; line-height:1.5; }
```

## Rendering

```bash
node scripts/screenshot.js working.html output.png 3 1080
python3 -c "from PIL import Image;w,h=Image.open('output.png').size;print(f'{w}x{h} 1:{h/w:.2f}')"  # target 1:1.4–1.9
```

## Fallback: inline SVG Xiaohei (pure-code mode only)

When the user opts out of `image_gen`, replace `<img class>` content with an inline SVG in the `.shot` slot. This yields icon-grade Xiaohei, not Ian-grade — keep it rough and minimal.

```html
<svg class="shot-svg" viewBox="0 0 300 200" aria-label="小黑在处理信息">
  <path d="M120 70 C100 78, 96 130, 120 148 C150 168, 196 150, 200 112 C204 78, 158 58, 120 70 Z"
        fill="#171717" stroke="#171717" stroke-width="3"/>
  <circle cx="138" cy="104" r="6" fill="#fffefb"/><circle cx="166" cy="102" r="6" fill="#fffefb"/>
  <path d="M132 148 L126 184 M172 148 L180 184" stroke="#171717" stroke-width="5" fill="none" stroke-linecap="round"/>
  <path d="M40 60 C90 44, 110 56, 122 78" stroke="#e8752e" stroke-width="6" fill="none" stroke-linecap="round"/>
</svg>
```

# HTML Patterns

Use these patterns as starting points. Keep the file self-contained.

## Base

```html
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="UTF-8" />
<style>
* { box-sizing: border-box; }
body {
  width: 750px;
  margin: 0;
  padding: 46px 40px 38px;
  background: #fffefb;
  color: #171717;
  font-family: -apple-system, BlinkMacSystemFont, "PingFang SC", "Noto Sans SC", "Helvetica Neue", Arial, sans-serif;
}
.wrap { display: flex; flex-direction: column; gap: 24px; }
.eyebrow {
  display: inline-flex;
  align-self: flex-start;
  border: 1.5px solid #171717;
  border-radius: 999px;
  padding: 5px 12px 4px;
  font-size: 12px;
  font-weight: 800;
  letter-spacing: 0;
}
h1 {
  margin: 12px 0 8px;
  font-size: 32px;
  line-height: 1.15;
  font-weight: 900;
  letter-spacing: 0;
}
.subtitle { color: #76716b; font-size: 13px; line-height: 1.45; }
.rule { height: 2px; background: #171717; margin-top: 18px; }
.thesis {
  border-left: 5px solid #e8752e;
  padding: 14px 18px;
  background: #fff8ec;
  font-size: 19px;
  line-height: 1.45;
  font-weight: 850;
}
.section {
  display: grid;
  grid-template-columns: 170px 1fr;
  gap: 18px;
  align-items: stretch;
  border: 1.5px solid #171717;
  border-radius: 8px;
  padding: 16px;
  background: #fffefb;
}
.visual {
  min-height: 132px;
  border-right: 1.5px dashed #d8d1c7;
  padding-right: 12px;
}
.section h2 {
  margin: 0 0 9px;
  font-size: 19px;
  line-height: 1.25;
  font-weight: 900;
}
.points {
  margin: 0;
  padding-left: 18px;
  color: #333333;
  font-size: 14px;
  line-height: 1.65;
}
.note {
  font-size: 12px;
  font-weight: 800;
  fill: #d83a2e;
}
.takeaway {
  background: #171717;
  color: #f8f3ea;
  border-radius: 8px;
  padding: 20px 22px;
}
.takeaway strong { color: #ffbf58; }
.footer {
  display: flex;
  justify-content: space-between;
  gap: 18px;
  color: #76716b;
  font-size: 11px;
  line-height: 1.45;
}
svg { display: block; width: 100%; height: auto; overflow: visible; }
.ink { stroke: #171717; stroke-width: 3; fill: none; stroke-linecap: round; stroke-linejoin: round; }
.thin { stroke-width: 2; }
.orange { stroke: #e8752e; }
.blue { stroke: #2f73d9; }
.red { stroke: #d83a2e; }
.xbody { fill: #171717; stroke: #171717; stroke-width: 2; }
.eye { fill: #fffefb; stroke: none; }
</style>
</head>
<body>
  <main class="wrap">
    <!-- content -->
  </main>
</body>
</html>
```

## Xiaohei SVG Fragment

```html
<svg viewBox="0 0 170 132" aria-label="小黑在处理信息">
  <path class="ink thin" d="M24 98 C54 82, 92 82, 140 96" />
  <path class="xbody" d="M77 42 C65 47, 62 74, 75 84 C89 96, 112 88, 115 68 C119 47, 96 35, 77 42 Z" />
  <circle class="eye" cx="87" cy="61" r="3.3" />
  <circle class="eye" cx="101" cy="60" r="3.3" />
  <path class="ink thin" d="M84 86 L80 106" />
  <path class="ink thin" d="M103 86 L108 106" />
  <path class="orange" d="M18 34 C46 24, 63 31, 75 48" />
  <path class="orange" d="M132 42 C119 46, 111 54, 108 66" />
  <text class="note" x="14" y="27">输入</text>
</svg>
```

## Section HTML

```html
<section class="section">
  <div class="visual">
    <!-- inline SVG metaphor -->
  </div>
  <div>
    <h2>01 把混乱先变成可处理</h2>
    <ul class="points">
      <li>先找核心判断，不平均摘句。</li>
      <li>把长段落压成 1 个动作。</li>
      <li>保留读者最需要的一次转折。</li>
    </ul>
  </div>
</section>
```

## Rendering

```bash
node scripts/screenshot.js input.html output.png 3 750
```

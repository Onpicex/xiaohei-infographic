# image_gen 提示词模板(每节一张小黑场景)

每节单独生成一张图,放进 `composite-flow.html` 的图槽。和 ian 原 skill 的最大区别:**这里生成的图绝对不写字**——文字全归 HTML。所以提示词必须显式禁止任何文字,且固定纯白底好无缝合成。

## 三步造隐喻(每节先做这个)

每次都从当前文章重新发明隐喻,不要照搬旧图。

1. **把抽象概念换成一个物理动作**:卡住、漏掉、变重、分拣、沉淀、发酵、开门、折叠、拆包、回流、缝合、压扁、捞取。
2. **把系统结构换成一个低科技物件**:坏机器、纸箱、抽屉、水管、邮筒、怪表盘、秤、井、梯子、线团、闸门、转盘、黑盒、打孔器、压面机、晾衣绳、怪工位(只选 1–2 个,别堆满)。
3. **让小黑承担这个动作**:不是站旁边看,而是卡在机器里、拉错线、守门、搬运、修补、称重、扶梯子、把东西塞进某个怪装置。

测试:如果去掉小黑这张图还成立,说明小黑只是装饰 —— 重做隐喻。

## 反复刻规则

`assets/examples/`(在 ian-xiaohei skill 内)只用于风格密度校准。除非用户明确说「照这张 / 复刻这个构图」,否则不要复用这些已知构图:传送带两断点、小黑拉判断杆、小黑变漏斗分拣、小黑切素材鱼、小黑牵承接路径、小黑拉三层信息源、三个小黑喇叭/搭桥/开门、盖章话术工具箱、举牌看常见坑。同类主题也要换新隐喻。

## 单张提示词模板

按节内容替换 `{大括号}` 变量。一张图只讲一个核心结构。

```text
Generate one standalone hand-drawn Chinese-illustration scene.

Visual DNA:
Pure white background (seamless, no panel, no border, no frame). Minimalist black hand-drawn line art with slightly wobbly pen lines — not vector, not mechanical, no heavy outline. Lots of empty white space; the subject occupies about 40%-60% of the canvas. Clean, absurd, deadpan product-sketch feeling. No gradients, no shadows, no paper texture, no complex background, no commercial vector style, no PPT infographic look, no cute mascot poster, no children's illustration, no realistic UI.

Recurring IP character (required, consistent across every section):
小黑 — a small solid-black absurd creature: uneven hand-drawn body (blob / cylinder / black box shape), two white dot eyes, tiny thin legs, optional thin arms, blank serious expression. 小黑 must PERFORM the core conceptual action, not decorate the scene. Deadpan and slightly bizarre, never cute.

Core idea of this scene:
{这一节要表达的核心意思}

Composition / what 小黑 is doing:
{小黑在哪里、正在做什么、主要物件是什么、东西怎么流动}

Props (use only 1-2):
{物件1} / {物件2}

Color use:
Black for line art and 小黑. Orange only for the main path / flow / arrow. Red only for a key problem or result. Blue only for a secondary or system hint. Color must be sparse — when in doubt, use less.

HARD CONSTRAINTS:
- Absolutely NO text, NO letters, NO numbers, NO Chinese characters, NO labels, NO captions anywhere in the image. (All wording is added later in HTML.)
- Pure white background, no enclosing box/border/panel.
- One scene explains only ONE core structure.
- Aspect roughly 3:2 horizontal.
- Do not copy prior example compositions; this metaphor must be freshly invented for this specific section.
- Clear but not instructional, interesting but not childish, strange but clean.
```

## 几个要点

- **身份一致**:每节的小黑外形描述句保持不变(黑实心 / 白点眼 / 细腿 / 空表情),否则一张卡里几个小黑长得不一样会很怪。
- **比例 3:2**:对齐模板 `.shot img` 的 `aspect-ratio: 3/2`。生成图即使不是精确 3:2 也没关系,`object-fit: contain` + 白底会无缝裁进去。
- **不写字 = 不用因改文案重生图**:文案调整只动 HTML,省额度也省时间。
- **批注不在图里**:红橙蓝手写批注是 HTML 的 `.note` overlay,不要让模型在图上画字。

## 局部重生成(出问题时)

- **小黑太装饰** → 重生成,提示词强调 "小黑 must be the one performing the strange work that explains the idea, centered in the action"。
- **太像 PPT / 流程图** → 强调 "hand-drawn whiteboard sketch, no boxes, no arrows grid, lots of white space"。
- **太可爱** → 强调 "deadpan, blank serious expression, not cute, not a mascot"。
- **冒出文字** → 重生成并再次强调 NO text 那条;或在合成前用图像编辑把文字抹掉补白。
- **底色不纯白** → 强调 "pure flat white background #ffffff, no tint, no texture"。

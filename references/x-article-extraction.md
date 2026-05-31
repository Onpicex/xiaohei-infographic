# X (Twitter) Article 全文抽取

做信息图前必须拿到**真正的全文**,不要拿预览/截断版去总结。X Article 的全文有几条路被堵死,只有一条稳:

## 失败的路(别浪费时间)

- **登录态的文章页 DOM** (`/i/article/<id>`):未登录会重定向到登录墙;登录态抓到的 DOM 也往往只有预览块。
- **syndication `tweet-result` 端点**:对长文 Article 只返回首段预览,不给正文。
- `xurl read` 等工具遇公开帖也常返回 `401` / 登录墙。

这些只拿到预览时,**不要靠推测补全正文**。

## 能用的路:fxtwitter 的 `article.content.blocks`

fxtwitter/fixupx 的 API 会把 X Article 的完整正文拆成结构化 blocks 返回。

```bash
# 用帖子 id;返回 JSON,正文在 .tweet.article.content.blocks[]
curl -s "https://api.fxtwitter.com/<user>/status/<post_id>" \
  | python3 -c "import sys,json; d=json.load(sys.stdin); \
import itertools; \
blocks=(d.get('tweet',{}).get('article',{}) or {}).get('content',{}).get('blocks',[]); \
print('\n'.join(b.get('text','') for b in blocks if b.get('text')))"
```

- 每个 block 通常含 `type`(paragraph / heading / 等)和 `text`,按顺序拼起来就是全文。
- 也可不带域名前缀直接 `https://api.fxtwitter.com/i/status/<post_id>`,视具体帖子而定。
- 拿到全文后再做抽取:标题 / thesis / 3–5 节 / takeaway / 来源。

## 回退:公共 Markdown 桥(jina)

fxtwitter 偶尔对某些 Article 不给 blocks 时,试 jina 的只读 Markdown 桥:

```bash
curl -L "https://r.jina.ai/https://x.com/<user>/status/<post_id>"
```

- 能把整篇 Article 渲染成 Markdown,即便原页面 `401`。
- 只用它返回的正文文本。如果它也只回登录壳 / 预览,就**标注为不完整,并向用户要粘贴版 / 导出版**,不要硬编。

## 普通推文(非 Article)

短推文直接用 fxtwitter 的 `.tweet.text` 即可,无需走 blocks:

```bash
curl -s "https://api.fxtwitter.com/<user>/status/<post_id>" \
  | python3 -c "import sys,json; print(json.load(sys.stdin)['tweet']['text'])"
```

## 原则

拿到的若只是预览,就在交付里**显式标注 preview-level**,并说明缺全文;绝不把推测内容当原文做进信息图。

# Theme Studio

**静态网站的主题编辑器。**左边调色、右边实时预览，保存即重新生成网站。

给不会写 CSS 的人用：不用记十六进制颜色、不用翻样式表、不用懂变量。`node editor.js` 启动，浏览器里点几下，配色和排版就改完了。

零依赖——只用 Node.js 自带模块，不装任何 npm 包。

---

## 它解决什么问题

静态博客的配色通常藏在 CSS 里，改一个主色要翻文件、找选择器、担心改坏版式。Theme Studio 把这件事变成三个滑杆和几个取色器，并且**只写 `theme.json`**——`style.css` 的骨架永远不动，所以不可能把版式改坏。

## 功能

- **六套预设**：朱红纸本、靛蓝冷灰、墨黑极简、松墨绿、高对比、夜蓝，点一下立刻套用；
- **亮色 / 暗色分开调**，暗色在系统切到深色模式时自动生效；
- **七个颜色位**：纸色、背景块、墨色、次要文字、强调色、强调浅、线条色，色块与十六进制值双向同步；
- **排版三滑杆**：字号、行高、版心宽度，拖动时预览实时变化；
- **五种字体**：宋体、黑体、楷体、系统界面、等宽；
- **实时预览**：右边是真实页面，不是模拟；
- **保存即重建**：写完 `theme.json` 自动调用站点的 `build.js`；
- **一键还原**：恢复默认配色。

## 前提

- Node.js 18 或更高版本（<https://nodejs.org/zh-cn>）；
- 你的网站要符合这套约定（见下面的"兼容性"）。

## 用法

### 方式一：把文件夹拖到启动脚本上

把 `start.cmd` 放在任何地方，然后把**你的网站文件夹拖到它上面**松开。浏览器会自动打开编辑器。

### 方式二：命令行

```bash
node editor.js --site "D:\path\to\my-site"
```

不传 `--site` 就用当前目录：

```bash
cd D:\path\to\my-site
node D:\path\to\theme-studio\editor.js
```

## 参数

| 参数 | 说明 | 默认 |
|---|---|---|
| `--site <目录>` | 要编辑的网站根目录 | 当前目录 |
| `--port <端口>` | 本地服务端口 | `4100` |

示例：

```bash
node editor.js --site ../my-blog --port 4200
```

## 它对网站做了什么

只碰两个地方：

1. 读取并写入 `<网站目录>/theme.json`；
2. 如果该目录存在 `build.js`，保存时执行 `node build.js` 重新生成。

**不修改** `docs/` 里的任何 HTML，**不联网**，**不上传**，服务只监听 `127.0.0.1`。

## theme.json 结构

```json
{
  "colors": {
    "paper": "#f4efe3",
    "paper2": "#eee7d6",
    "ink": "#1a1613",
    "muted": "#6d6255",
    "accent": "#971c1c",
    "accent2": "#b23a2e",
    "rule": "#d9ceb9"
  },
  "dark": {
    "paper": "#131110",
    "paper2": "#1c1917",
    "ink": "#e9e1d1",
    "muted": "#9b8f7e",
    "accent": "#d1554a",
    "accent2": "#e0705f",
    "rule": "#302a24"
  },
  "type": {
    "fontBody": "\"Songti SC\", ... , serif",
    "fontSize": "17.5px",
    "lineHeight": "1.95",
    "maxWidth": "44rem"
  }
}
```

字段含义：

| 字段 | 对应 CSS 变量 | 说明 |
|---|---|---|
| `colors.paper` | `--paper` | 页面底色 |
| `colors.paper2` | `--paper-2` | 引用块、代码块等次级底色 |
| `colors.ink` | `--ink` | 正文与标题颜色 |
| `colors.muted` | `--muted` | 日期、摘要等次要文字 |
| `colors.accent` | `--red` | 强调色（链接、标题竖线、顶部色条） |
| `colors.accent2` | `--red-2` | 强调色的浅一档，用于悬停 |
| `colors.rule` | `--rule` | 分割线、边框 |
| `type.fontSize` | — | 正文字号 |
| `type.lineHeight` | — | 正文行高 |
| `type.maxWidth` | `--max` | 版心宽度 |

`dark.*` 与 `colors.*` 一一对应，是深色模式下的取值。

## 兼容性

Theme Studio 不改你的 HTML，它只写 `theme.json`。所以你的网站需要满足：

1. 有一个 `docs/` 目录存放生成好的页面（编辑器从 `/site/` 提供预览）；
2. 样式表里用 CSS 变量取色，变量名与上表一致；
3. 最好有 `build.js`，能把 `theme.json` 变成一份 `theme.css`——没有的话编辑器仍然可用，只是保存后你需要自己重新生成。

配套的博客模板（含恰好满足这三点的 `build.js` 和 `style.css`）在这里：
<https://github.com/xinpeiliang76-del/kkr->

## 安全说明

- 只监听 `127.0.0.1`，局域网内其他设备也访问不到；
- 颜色必须匹配 `#rgb` / `#rrggbb` / `#rrggbbaa`，字体名不允许包含 `; { } < > \`，因此无法通过输入框注入 CSS 或脚本；
- 请求体上限 1 MB；
- 没有 `eval`、没有动态 `require`、没有远程请求。

## 许可

MIT。随便用、随便改、商用也行，保留版权声明即可。

---

作者：lxpwp · <https://github.com/xinpeiliang76-del>

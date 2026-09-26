# side-inbox

[English](README.md) · **中文**

把 AI **侧边对话（side chat）** 里写出来的东西存下来，而且不污染主对话。

Claude Code 的 side chat、Codex 的 `/side`，都适合"主任务继续跑，我在旁边就某一段追问几句"。但它们是只读、临时的：不能存文件，关掉就没了。side chat 里整理出一份值得保留的东西（一个方案、一段总结、几百行的文档），现在唯一的出路是粘回主对话——然后这些内容永久留在主对话的上下文里，每一轮都要重新付费。

side-inbox 给这些产出一个去处：

```
side chat  ──⌘C──►  ⌃⌥I（快捷键）──►  ~/inbox/2026-09-26-1530-数据配比方案.md
                                              │
任意项目里的主对话  ──  /merge  ◄──────────────┘   什么时候要用、要归档、要删，你说了算
```

- **一键保存。** 复制，按快捷键，右上角通知告诉你存了什么。主对话完全不参与，上下文一个字不涨。
- **原样落盘。** 你复制的是什么，文件里就是什么，中间没有模型经手。
- **防存错。** 上次存完后没复制新东西、或者收件箱里已经有一模一样的内容，都不会存。
- **不挑来源。** 存的是剪贴板，所以 Claude Code、Codex、ChatGPT 网页、PDF 里复制的都行。
- **用的时候再取。** 在任何项目的对话里问"收件箱里有什么"、读某一条、或者用 `merge` 把它放进当前项目。

## 安装（macOS）

```bash
git clone https://github.com/zaozhiyi/side-inbox.git
cd side-inbox
./install.sh
```

安装脚本会：

1. 把 `side-inbox` 命令放到 `~/.local/bin`，并建好 `~/inbox`；
2. 给 **Claude Code**（`~/.claude/skills`）和 **Codex**（`~/.codex/skills`）装上 `inbox`、`merge` 两个技能——装了哪个就给哪个装。两边用的是同一份 `SKILL.md`；
3. 在你的 Mac 上现场生成并签名一个快捷指令，然后打开它。点 **添加快捷指令**，再：
   - 双击打开它，点 **ⓘ → 添加键盘快捷键**，按下比如 **⌃⌥I**；
   - 快捷指令 → 设置 → 高级，勾选 **允许运行脚本**。

不想要第 3 步可以用 `./install.sh --no-shortcut`。`./uninstall.sh` 会删掉除 `~/inbox` 以外的所有东西。

<details>
<summary>手动设置快捷键</summary>

在「快捷指令」App 新建一个快捷指令，加入动作「运行 Shell 脚本」，内容填：

```
"$HOME/.local/bin/side-inbox" quick
```

再在 ⓘ 里给它绑一个键盘快捷键。
</details>

## 使用

| 你想… | 这样做 |
|---|---|
| 从 side chat（或任何地方）存一段 | 复制，按 **⌃⌥I** |
| 存之前先看一眼 | 在对话里敲 `/inbox`（Claude Code），它先给你看开头几行再问你存不存 |
| 看收件箱里有什么 | 说"收件箱里有什么"，或敲 `/merge` |
| 在当前工作里用某一条 | "读收件箱 2 号"——这时内容才进入对话 |
| 把某一条放进当前项目 | "2 号放到 notes/方案.md" |
| 清理 | "3 号、4 号不要了" |

Codex 里技能会按名字或描述自动触发，也可以显式提及（`$inbox`、`$merge`）。

一切都是普通文件：每条是 `~/inbox/*.md`，`~/inbox/.log` 记录了什么时候存了什么、后来去了哪。

## 为什么 side chat 自己存不了

这不是没做，是两家都**故意**把 side chat 设计成只读、临时的——为了防止主任务在跑的时候，侧边对话改动你的工作区。

- **Claude Code 桌面端**（2026 年 9 月从 App 包里观察到的）：side chat 是主会话的一个分叉，启动参数是 `persistSession: false`（不写硬盘），工具调用一律拒绝；它还不加载任何配置、hook、MCP。关掉就删。
- **Codex**：`/side` 以 `ephemeral = true` 分叉线程（`codex-rs/tui/src/app/side.rs`），没有落盘文件，关闭、重启或过一段时间就消失。见 [openai/codex#26227](https://github.com/openai/codex/issues/26227)。

两家都不允许第三方往 side chat 里加东西，所以 side-inbox 选在用户本来就会经过的那道边界上工作：剪贴板。真正的解决应该在上游：给 side chat 一个很窄的"存到收件箱"能力——只能写、只能写进一个文件夹——就能省掉复制这一步，又不让 side chat 碰到工作区。

## 局限

- 只支持 macOS（用到了 `pbpaste`、快捷指令和系统通知）。
- 复制这一步还得手动，side-inbox 看不到 side chat 内部。
- 存的是剪贴板。通知里会显示标题和行数，复制错了一眼能看出来，用 `merge` 删掉即可。

## 许可证

MIT

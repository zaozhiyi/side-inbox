# Contributing / 参与贡献

[English README](README.md) · [中文首页](README.zh-CN.md)

## Scope / 项目范围

Keep selected text locally, then let the user decide when and where to use it. Priorities are reliable capture, clear feedback, and consistent retrieval in Claude Code and Codex. Full session migration and a replacement chat client are outside the current scope.

先在本地保存选中的文字，再由用户决定何时、在哪使用。优先改进保存可靠性、操作反馈，以及 Claude Code / Codex 的一致取用体验。整会话迁移和另做聊天客户端不在当前范围内。

## Report an issue / 反馈问题

Use the [issue templates](https://github.com/zaozhiyi/side-inbox/issues/new/choose). For shortcut bugs, distinguish key delivery, clipboard capture, and notification display. Include versions and a minimal, non-sensitive example. Do not upload your inbox, chat recordings, or logs without checking their contents.

请使用 [issue 模板](https://github.com/zaozhiyi/side-inbox/issues/new/choose)。快捷键问题要区分“按键没触发”“剪贴板没存下”“通知没显示”，附版本与最小示例。上传前检查内容，不直接提交自己的收件箱、聊天录屏或日志。

## Changes and validation / 修改与验证

- Keep English and Chinese user documentation aligned. Product behavior claims need a source, date, and desktop/CLI scope.
- Keep collection free of model calls and automatic messages to a working chat. Listing may show short previews; full-text reading remains deliberate.
- Test code changes with a temporary inbox and harmless fixtures. Cover the behavior changed, including failures; do not use someone’s real clipboard or inbox without their intent.
- For hotkeys, test physical keys in the target app. A shell invocation or synthesized key event alone does not prove global hotkey delivery.
- Describe the trigger, resulting behavior, checks performed, and any remaining limits in a PR. Do not commit personal files, credentials, recordings, or unrelated local changes.

对应中文要求：中英文同步；产品行为注明来源、日期与适用端；收集不调用模型、不自动发消息；正文按需读；代码验证使用临时收件箱；全局快捷键要用真实键盘在目标应用里验证；PR 说明改动与验证，排除个人文件。

## Current priorities / 当前优先事项

These are directions, not shipped features or release promises.

以下是改进方向，不代表已经发布，也不是交付承诺。

1. **Reliable hotkeys / 快捷键可靠性：** evaluate a native helper across apps and keyboard layouts, preserve user configuration during updates, and make installation/removal predictable.
2. **Safer file handling / 文件保存可靠性：** handle rapid or concurrent captures without filename collisions; improve failure feedback and clipboard-state handling.
3. **Consistent configuration / 配置一致性：** coordinate inbox paths across the command, shortcut, and skills before presenting custom paths as a simple setting.

## License / 许可

Contributions are made under the repository’s [MIT license](LICENSE).

贡献按仓库的 [MIT 许可证](LICENSE) 提供。

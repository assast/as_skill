---
name: mindmap
description: Use when Codex needs to turn a topic, notes, requirements, or a document into a mind map or a markmap-compatible hierarchical outline, optionally rendered through the configured markmap MCP server.
---

# Mindmap

把主题、文档或调研结果整理成适合思维导图展示的层级结构，并尽量通过当前已配置的 `markmap` MCP 生成可视化结果。

## 工作流

1. 先提炼中心主题，确认最核心的主节点。
2. 将内容压缩成 3 到 6 个一级分支，避免一上来就铺满细节。
3. 每个节点使用短语表达，不写成长段说明。
4. 先生成 markmap 兼容的 Markdown 结构，再按需调用当前 `markmap` MCP 生成结果。
5. 如果当前工具支持预览，则预览；否则至少输出文件位置或 Markdown 结果。

## 输出原则

- 一级分支表示主要维度、模块或阶段。
- 二级及以下分支只保留关键事实、关键动作、关键风险。
- 同层级节点尽量保持并列关系，不要混乱跳跃。
- 如果主题更适合时间线或对比表，也要明确指出，不要硬拽成脑图。

## MCP 使用

- 优先使用当前已启用的 `markmap` MCP。
- 如果 MCP 不可用，至少输出一份可直接用于 markmap 的 Markdown。
- 生成结果后，说明核心结构和输出位置。

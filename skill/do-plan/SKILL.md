---
name: do-plan
description: Use when the user approves a previously written local plan document and wants Codex to execute it step by step, keeping the local plan file updated with progress, validation, and deviations.
---

# Do Plan

按已批准的本地计划文档执行任务，并持续更新计划状态。

## 前提

- 必须先有明确的计划文档。
- 如果用户没有指定计划文件，先定位最相关的一份，再向用户确认。
- 如果现实情况和计划明显不一致，先更新计划，再继续执行。

## 工作流

1. 重新读取计划文档和当前代码，确认计划没有过期。
2. 将当前要执行的步骤标记为 `[in_progress]`。
3. 一次只推进一个主要步骤，避免多线乱拧。
4. 每完成一项，立即更新为 `[completed]`，并写下简短结果。
5. 遇到阻塞就标记为 `[blocked]`，说明原因和建议处理方式。
6. 关键改动完成后运行对应验证，并把验证结果写回计划或执行总结。

## 状态格式

统一使用这些状态标签：

- `[pending]`
- `[in_progress]`
- `[completed]`
- `[blocked]`

## 执行要求

- 执行阶段尊重原计划，但不要机械照抄。
- 如果发现更优路径，可以调整，但必须先把计划文档同步更新。
- 不依赖任务管理 MCP；执行状态只维护在本地计划文档里。
- 最后输出完成情况、验证结果、剩余风险和后续建议。

---
name: plan
description: Use when Codex needs to analyze a complex task, inspect a codebase or documents in read-only mode, and produce an actionable local plan document before implementation.
---

# Plan

进入规划模式，只做分析和计划，不直接修改业务代码。

## 铁律

- 规划阶段默认只读，不写源代码。
- 先把现状摸清，再给执行计划。
- 计划文档必须落地到本地文件，不能只在对话里空口白话。
- 不依赖任务管理 MCP，同步状态以本地计划文档为准。

## 计划文件位置

- 优先使用当前工作区下的 `.codex/plans/`
- 如果当前工作区不适合写入，再回退到 `~/.codex/plans/`

文件名建议：

```text
YYYYMMDD-short-task-name.md
```

## 工作流

1. 读取需求，确认目标、约束和交付物。
2. 只读探索相关代码、文档、配置和测试。
3. 识别关键模块、依赖关系、未知点和主要风险。
4. 生成一份可执行的本地计划文档。
5. 在对话里总结计划重点，等待用户批准后再进入执行阶段。

## 计划文档结构

```markdown
# <任务标题>

## Goal
- ...

## Context
- ...

## Findings
- ...

## Assumptions
- ...

## Plan
1. [pending] ...
2. [pending] ...

## Validation
- ...

## Risks
- ...

## Open Questions
- ...
```

## 写作要求

- 每个执行步骤都要能落地，避免“优化一下”“完善一下”这种废话。
- 每个步骤尽量带上验证方式或完成标志。
- 如果用户后续要求更新计划，优先修改同一份计划文档，不重复新建。

# 技能列表索引

本仓库当前收录 8 个技能，统一放在 `skill/<skill-name>/SKILL.md`。本文件只做索引和快速说明，具体工作流、约束和输出格式以各技能自己的 `SKILL.md` 为准。

## 技能总览

| 技能 | 入口文件 | 用途 | 依赖/备注 |
| --- | --- | --- | --- |
| `api_docs_generator` | [skill/api_docs_generator/SKILL.md](skill/api_docs_generator/SKILL.md) | 从源码发现并整理 HTTP API 文档 | 适合路由和处理器梳理 |
| `check-fix` | [skill/check-fix/SKILL.md](skill/check-fix/SKILL.md) | 分析修复或改动的影响、兼容性和测试缺口 | 适合回归风险评估 |
| `do-plan` | [skill/do-plan/SKILL.md](skill/do-plan/SKILL.md) | 按本地计划文档逐步执行任务并同步状态 | 依赖已有计划文档 |
| `env_editor` | [skill/env_editor/SKILL.md](skill/env_editor/SKILL.md) | 实现图形化 `.env` Web 编辑器 | 偏实现方案与步骤说明 |
| `mindmap` | [skill/mindmap/SKILL.md](skill/mindmap/SKILL.md) | 将主题整理成思维导图结构 | 可结合 `markmap` MCP 使用 |
| `plan` | [skill/plan/SKILL.md](skill/plan/SKILL.md) | 只读分析并生成本地计划文档 | 默认计划落地到 `.codex/plans/` |
| `play` | [skill/play/SKILL.md](skill/play/SKILL.md) | 通过 Playwright 访问、交互和截图页面 | 依赖 `playwright` MCP |
| `prompt` | [skill/prompt/SKILL.md](skill/prompt/SKILL.md) | 诊断并优化 prompt、系统提示词和代理指令 | 输出多档优化方案 |

## 按场景看

- 规划与执行：`plan`、`do-plan`、`check-fix`
- 文档与表达：`api_docs_generator`、`prompt`、`mindmap`
- 页面与配置：`play`、`env_editor`

## 维护约定

- 新增技能时，同时补 `skill/<name>/SKILL.md` 和本索引表。
- 技能名以目录名和 `SKILL.md` 头部的 `name` 为准，别整三套叫法。
- 如果技能依赖 MCP、外部命令或特殊目录结构，在“依赖/备注”列写清楚。
- 详细步骤、边界条件和输出格式写在各自 `SKILL.md`，本文件只保留索引信息。

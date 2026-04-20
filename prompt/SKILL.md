---
name: prompt
description: Use when the user wants to improve a prompt, system prompt, workflow instructions, agent spec, or LLM input template for better quality, control, structure, or reliability.
---

# Prompt

把用户提供的 prompt 或指令集做一次结构化诊断和优化。

## 工作流

1. 判断 prompt 类型。
- 通用问答
- 编程代理
- 内容生成
- 数据提取
- 审核或分类
- 多步骤工作流

2. 诊断主要问题。
- 目标是否明确
- 输入上下文是否足够
- 约束是否清晰
- 输出格式是否可执行
- 是否缺少边界条件、示例或评估标准

3. 提供三档优化。
- Quick Fix：最小改动，快速提升可用性
- Balanced：结构更完整，适合日常稳定使用
- Strong Control：约束更强，适合高一致性场景

4. 给出最终版本。
- 输出一份推荐版 prompt
- 说明做了哪些关键改动，以及这些改动解决了什么问题

## 输出格式

```markdown
## Prompt Diagnosis
- Type:
- Goal:
- Main Issues:

## Optimization Options
### Quick Fix
...

### Balanced
...

### Strong Control
...

## Recommended Prompt
...

## Why This Works
- ...
```

## 额外要求

- 如果用户指定了目标模型、工具能力或输出格式，要显式适配。
- 如果原 prompt 已经不错，重点做收口和去歧义，不要为了改而改。
- 不要假设存在自定义 slash 子命令；直接围绕用户当前请求完成诊断和改写。

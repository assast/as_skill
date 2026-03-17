---
name: skill-git-publisher
description: Publish an OpenClaw skill folder to a Git repository: clone repo, copy a skill directory (either the directory itself or its contents) into a target path, overwrite on conflict, commit with specified author/email, and push. Use when the user asks to “把skill提交到git/推送skill到仓库/发布skill到GitHub” or needs to sync a skill folder into a repo with correct directory structure.
allowed-tools: Bash(git*), Bash(rsync*), Bash(cp*), Bash(mkdir*), Bash(rm*), Bash(find*), Bash(test*), Bash(sed*), Bash(python3*)
---

# Skill: skill-git-publisher

目标：把某个 skill 目录“发布/同步”到指定 Git 仓库，并保证 **目录结构** 与 **覆盖策略** 符合用户预期，最后 commit + push。

## 重要澄清（必须问 3 个问题，避免踩坑）
在执行前先问清楚，并把答案用可复制的要点复述给用户确认：

1) **复制语义**：
- A. 复制“目录本身”（例如把 `api_docs_generator/` 放到 repo 根目录下，得到 `repo/api_docs_generator/...`）
- B. 复制“目录内容到目标路径”（例如把 `api_docs_generator/` 里的内容摊平到 repo 根目录，得到 `repo/SKILL.md`）

2) **目标路径**：
- repo 根目录？还是 `skills/<name>/` 这类子目录？

3) **覆盖策略**：
- 遇到同名文件/目录是否覆盖？
- 是否允许删除目标路径里“源 skill 不存在的文件”（rsync --delete）？默认 **不删除**，只覆盖/新增。

> 如果用户已经明确给了三点信息，可跳过提问，但仍要用一句话复述确认。

## 安全护栏
- 只做：`git clone`、文件复制、`git add/commit/push`。
- 不运行 skill 内脚本。
- 不提交 workspace 噪声：不要把 `/tmp`、`.openclaw/`、日志、导出物等带进仓库。

## 推荐实现（确定性脚本）
优先用 `scripts/publish_skill_to_git.sh`，它做：
- clone 到临时目录
- 根据 `--mode dir|contents` 决定复制语义
- 复制时覆盖冲突（可选 --delete）
- 配置 git author/email
- commit + push（若无变更则退出）

## 典型用法（对话层）
用户说：
- “检出 XXX 仓库，把 skill 目录复制进去，覆盖同名文件，提交并推送，署名 xxx”

你输出一个执行计划（3–6 行），并提示：
- 若需执行，用户回复确认口令：`确认推送skill`

收到确认后再执行脚本。

## 输出要求
完成后返回：
- 远端仓库 URL
- commit hash
- 变更概览（新增/删除/修改的文件数）
- 最终目录结构（目标路径下 tree 2 层即可）

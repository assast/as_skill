---
name: play
description: Use when Codex needs to open a URL, inspect a page, reproduce browser behavior, test a local web app, or interact with a site using the configured Playwright MCP tools.
---

# Play

使用当前已配置的 `playwright` MCP 完成真实页面访问和交互。

## 工作流

1. 从用户当前请求中提取目标链接或页面目标。
2. 优先在当前标签页开始，不要一上来开很多标签。
3. 先导航，再获取页面快照，确认页面当前状态。
4. 如果页面需要点击、展开、滚动或输入后才渲染内容，先做必要交互，再继续观察。
5. 如果页面跳到登录页，说明当前状态；涉及账号、验证码或敏感信息时，不要擅自填写。
6. 如果流程卡住，明确说明卡在哪一步、页面实际表现是什么、下一步需要什么信息。

## 执行要点

- 使用当前可用的 `playwright` MCP 浏览器导航、快照、点击、输入、等待和截图能力。
- 判断页面状态时，以真实页面结果为准，不根据猜测下结论。
- 本地页面测试优先刷新保持上下文，不要频繁跳转导致历史栈混乱。
- 页面有懒加载或异步刷新时，主动等待合理时长再判断。

## 失败处理

- 如果 `playwright` MCP 当前不可用，直接说明 MCP 未连接或不可用。
- 如果页面加载失败、元素找不到、权限不足或网络异常，记录实际错误并告知用户。
- 如果目标站点限制访问、需要登录或需要用户授权，明确说明阻塞点。

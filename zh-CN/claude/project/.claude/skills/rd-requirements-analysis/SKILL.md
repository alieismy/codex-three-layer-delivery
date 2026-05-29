---
name: rd-requirements-analysis
description: >-
  Use when analyzing user needs, structuring requirements, writing PRDs, SRS
  documents, or user stories. Use when raw requirements, meeting notes, or
  feature requests need to be structured and prioritized. Do not use for
  technical design or code implementation.
---

# $rd-requirements-analysis

将模糊用户需求转化为**结构化、可验证的需求文档**。

## 交付物

- 结构化需求文档（PRD / SRS / 用户故事集）
- 干系人分析矩阵（复杂项目）
- 需求追踪矩阵（可选）

## 执行步骤

### 1. 需求采集与澄清

- 区分用户原始表述和结构化需求，保留原始表述不篡改意图
- 识别隐含假设，显式列出
- 对模糊点逐条提问确认，不猜测填充
- 使用 5W1H 框架（Who / What / Why / When / Where / How）覆盖需求维度

### 2. 需求分类与结构化

按以下维度分类整理：

| 类别 | 内容 |
|------|------|
| 功能需求（FR） | 系统必须做什么 |
| 非功能需求（NFR） | 性能、可用性、可扩展性、安全性、兼容性 |
| 约束条件 | 技术栈、平台、法规、预算、时间 |
| 假设 | 未确认但影响设计的前提 |
| 排除项 | 明确不做的事项 |

### 3. 优先级标注

每项需求标注优先级：

- **P0（Must Have）**：不实现则项目失败
- **P1（Should Have）**：重要，但可在下一迭代
- **P2（Nice to Have）**：有则更好
- **P3（Won't Have）**：已识别但明确排除

### 4. 验收标准定义

每项功能需求附可验证的验收标准：
- Given / When / Then 格式
- 包含正常路径、异常路径和边界条件

### 5. 可行性初评

对关键需求做初步可行性判断：
- 技术可行性：是否有现成方案或需要定制开发
- 风险标注：标注高风险需求，建议原型验证

## 规范注入检查

执行前检查：
- 项目 AGENTS.md 中是否有需求规范模板要求
- 是否有已固化的产品标准或质量属性基线
- 已有需求文档的格式和命名约定

## MCP 工具使用

- **Context7**：查询类似产品的需求模式和最佳实践
- **Sequential Thinking**：复杂需求拆解和依赖分析
- **DeepWiki**：参考开源项目的需求组织方式

## 质量门禁

交付前核查：

- [ ] 核心场景 100% 覆盖
- [ ] 每项功能需求有验收标准
- [ ] 优先级已标注，P0 需求无遗漏
- [ ] 假设和排除项已明确列出
- [ ] 需求可验证（不存在无法测试的需求）
- [ ] 与用户确认理解无偏差

## 不做

- 不跳过需求澄清直接进入设计
- 不在需求分析阶段做技术选型
- 不给不可验证的需求放行

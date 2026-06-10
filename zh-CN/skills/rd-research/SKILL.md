---
name: rd-research
description: >-
  Use when collecting, validating, and structuring evidence for requirements,
  feasibility studies, technical proposals, architecture documents, detailed
  designs, standards/specifications, or document reviews. Use before or
  alongside rd-feasibility, rd-solution, rd-specification, or fact-dependent
  rd-review when external literature, standards, policy, vendor documentation,
  technical maturity, cost assumptions, or industry cases are needed. Do not use
  as a mandatory first step for every task, and do not use it to fabricate
  unavailable evidence.
---

# $rd-research

为下游文档交付成果和评审产出**可追溯证据包**。

## 交付物

- 研究问题和决策依赖
- 外部检索时的检索策略和查询记录
- 证据/来源表，包含权威性、日期、相关性和置信度
- 关键结论、冲突、缺口和假设
- 可供下游文档引用的资料笔记
- 证据应支撑的下游 Skill 建议

## 执行步骤

### 1. 研究范围

- 说明依赖证据的决策问题或文档章节
- 将宽泛课题拆成具体研究问题
- 区分必须证据和可选背景资料
- 判断证据支撑 `$rd-feasibility`、`$rd-solution`、`$rd-specification`、`$rd-design`、`$rd-requirement` 还是 `$rd-review`

### 2. 来源优先级

按以下顺序优先使用来源：

1. 用户提供的目标文档和权威项目材料
2. 有约束力的法律、法规、标准和官方政策文件
3. 官方厂商、框架、协议或产品文档
4. 同行评审论文、技术报告和标准化组织材料
5. 行业案例、可信分析报告和公开参考资料
6. 专家推断，且必须明确标注为推断

未实际查看相关内容的来源，不得作为证据引用。

### 3. 检索与收集

- 宽泛技术和标准检索优先使用英文关键词；最终输出使用用户要求的语言
- 对时效性事实记录主要检索意图、来源类型和检索日期
- 重要结论尽量使用多类来源交叉印证，不依赖单一结果
- 对付费或不可访问标准，只能引用已核实的元数据，条文内容应标注为不可确认

### 4. 来源评价

对有用来源逐项评价：

| 维度 | 检查内容 |
|------|----------|
| 权威性 | 官方 / 标准化组织 / 厂商 / 学术 / 行业 / 媒体 |
| 时效性 | 发布日期、版本、最新修订、废止状态 |
| 相关性 | 直接证据 / 间接支持 / 仅背景参考 |
| 可靠性 | 一手来源、二手摘要、是否与其他来源冲突 |
| 适用性 | 法域、行业、系统边界、场景匹配 |
| 置信度 | 高 / 中 / 低 / 未知 |

### 5. 证据综合

- 用面向决策的语言总结结论
- 标注来源冲突，并说明应优先采用哪个来源
- 区分事实、假设、估算、解释和建议
- 列出证据缺口和具体后续核验动作
- 除非用户要求完整文档，否则研究材料与最终正文措辞分离

## MCP 工具使用

- **web_search**：作为当前事实、政策、标准元数据、厂商页面和公开资料的主要工具
- **Tavily / Brave Search**：仅在 MCP 服务器已配置、凭据有效且已启用时使用
- **Context7**：用于框架、库和 API 官方文档
- **DeepWiki**：用于公开 GitHub 仓库架构和代码库理解
- **Browser / Playwright**：用于检查官方页面、PDF 或交互式来源
- **Sequential Thinking**：用于多来源冲突处理和复杂权衡综合

## 质量门禁

交付前核查：

- [ ] 研究问题和下游文档依赖已明确
- [ ] 重要结论有已查看来源，或已标注为假设
- [ ] 来源权威性、时效性、相关性和置信度可见
- [ ] 时效性事实在需要时包含检索日期或版本背景
- [ ] 来源冲突已披露，而不是被压平成单一结论
- [ ] 证据不足或不可访问内容已标注需人工核实
- [ ] 未编造引用、标准条款、市场数据或厂商结论

## 不做

- 不把 `$rd-research` 作为所有任务的强制前置步骤
- 不在未明确要求时编写最终 PRD、可研报告、技术方案、详细设计、标准规范或评审报告
- 不把未查看的搜索摘要当作已确认事实引用
- 不编造日期、版本、法律要求、标准条款、成本数字或基准结果

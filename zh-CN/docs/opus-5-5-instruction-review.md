# 面向 Opus 5.5 的 Claude 指令

原评估日期：2026-10-09。补充修订：2026-10-10。状态：保留 R1 和 R2；按用户要求撤销 R3，恢复第一性原理拆解、任务分类和多视角推演。补充修改属于 v1.8.5；原实验保留为历史记录。

## 决策与范围

面向 Claude 的指令大部分已经符合当前 Opus 5.5 指南：全局模板没有全大写强调语，没有要求写出推理过程，范围约束严格，Skill 描述长度和渐进加载都在文档限制之内。2026-10-09 的评估采纳了对 `claude/global/CLAUDE.md` 及其简体中文镜像的三处定点修改。下表保留当时的决策，并记录 2026-10-10 的修正：

| 编号 | 修改 | 指南依据 |
|---|---|---|
| R1 | 子代理规则删去"反例评审"，并增加：除非用户要求独立复核，不用子代理验证或复查自己的工作 | Opus 5 提示词页面建议不要用子代理验证模型自己的工作 |
| R2 | 删除 8 条"输出前自我审核" | Opus 5 不经提示就会自检，显式复查指令会导致过度验证；8 条中有 5 条几乎原样重复已有规则，另 3 条部分重叠 |
| R3 | 原先删除思维方法第 1–3 项；2026-10-10 撤销，恢复全部六项及原编号 | 一般性指令指南支持尝试精简提示词，但不能证明这些领域方法偏好有害。它们不要求披露内部推理，保留的反驳检验也规定了分析操作；删除属于维护选择，不是官方要求 |

2026-10-09 实验中的英文常驻全局文本从 18,438 字节减至 17,137 字节（−7.1%），从 152 行减至 138 行。这些历史测量对应 A0 与 A2，不代表撤销 R3 后的当前模板。

**2026-10-09 修改中未变更：**
- `claude/project/CLAUDE.md`、导入的 `AGENTS.md` 和 9 个 `rd-*` Skill。Skill 中的"验证"指交付物可验证，例如验收标准和验证动作，不是让模型复查自己。
- Codex 和 Cursor 侧文件，按维护者要求不动。原有分歧覆盖 R1–R3；补充修订后，三项思维方法重新一致，仍保留 Claude 特有的 R1/R2 差异。
- effort 设置。模板和 Skill 都不设置 effort。

**最强反对理由：** 每格只有一个样本，无法证明修改带来改进。测试只说明历史实验臂的冻结断言没有检测到回归。R1/R2 仍依据已发布的过度验证指南和重复提醒的删减。原先 R3 的理由夸大了分析偏好与规定思考步骤的区别；用户要求保留这些偏好。A/B 没有分别隔离 R2 和 R3，不能证明当前仅保留 R1/R2 的新组合质量。不作质量提升或效率收益声明。

## 官方指南与应用

以下页面于 2026-10-09 阅读。Opus 5.5 页面称 Opus 5 的提示词模式是合理起点，因此本文把 Opus 5 的指南沿用到 Opus 5.5。这是推断，不是 Opus 5.5 页面的单独表述。

| # | 指南 | 修改前仓库状态 | 处理 | 置信度 |
|---|---|---|---|---|
| 1 | effort 是控制思考深度的主要手段，比提示词更可靠。默认为 `medium`；同一档位下，Opus 5.5 在 `xhigh`/`max` 的思考量多于 Opus 5。只有实测出质量收益时才用 `xhigh`/`max` | 模板不设置 effort | 不改。Claude Code 支持 Skill 的 `effort` frontmatter，并覆盖会话级设置；会话在 `xhigh` 时写 `high` 会降档。2026-10-10 核查的官方 Skills 文档明确：claude.ai 上传允许字段不包括 `effort`，不支持的字段会导致打包或上传报错 | 高 |
| 2 | 聊天类系统提示中的"think carefully"之类指令可以删除；一般性指令优于规定的逐步思考 | 思维方法第 1–3 项表达领域方法偏好；任务分类也与项目路由重叠，但均不要求披露内部推理 | 2026-10-10 撤销 R3，按用户要求保留这些方法 | 对指令内容判断为高；效果未测量 |
| 3 | Opus 5 不经提示就会自检；显式复查指令会导致过度验证，应删除 | 8 条输出前自我审核，其中 5 条重复已有规则 | R2 | 中 |
| 4 | 不要用子代理验证或复查模型自己的工作 | 子代理规则把"反例评审"列为用途之一 | R1 | 中高 |
| 5 | 无人值守运行可能提前停止；点名具体的停止形态有帮助，但这段补充不应用于交互式会话 | 模板已要求下一步明确时继续执行 | 不改；仅在无人值守运行中观察到提前停止时再评估 | 中 |
| 6 | 进度更新和粘贴内容标记由 harness 侧负责 | 在撰写本文的会话中于 Claude Code CLI `2.1.295` 观察到 | 不改；不要添加限制进度更新的规则 | 高（单次会话） |
| 7 | 要求模型在回复中写出推理过程，可能触发 `reasoning_extraction` 拒答 | 没有此类指令；模板要求不逐项复述内部检查 | 不改 | 高 |
| 8 | Claude Code memory 指南：每个 `CLAUDE.md` 少于 200 行，指令具体且一致。`CLAUDE.md` 以 user message 形式注入，`/doctor prompt-audit` 可检查为旧模型编写的指令 | 历史 A0 全局文件 152 行，A2 为 138 行；导入的 `AGENTS.md` 为 111 行 | 不改结构。未在已安装的 CLI 上运行 `/doctor prompt-audit`，仍未验证 | 中 |
| 9 | Skill 编写：描述不超过 1,024 字符，`SKILL.md` 少于 500 行，引用只嵌套一层，不对 Opus 过度解释，用评估驱动迭代 | 描述 345–460 字符，104–162 行，引用一层 | 不改结构。缺口：Claude 侧测试此前只覆盖 Skill 选择和加载；下文 A/B 是首次 Opus 5.5 输出质量检查，规模很小 | 高 |
| 10 | "只报告高严重度问题"之类的字面范围措辞会降低召回率（原文针对代码审查） | `rd-review` 排除纯文风问题，要求每条发现给出位置、证据和影响 | 只记录为假设，不改 | 低 |

视觉、前端、多应用探索、多代理时间信号、关闭思考时的提示词和 API 破坏性变更，与本仓库的文档交付范围无关，未纳入评估。

## 历史 2026-10-09 A/B 冒烟测试

**设计**（执行前冻结）：
- **运行：** 4 个现有 eval 任务 × 3 个臂 × 每格 1 个样本 = 12 次 headless `claude -p` 运行。模型 `claude-opus-5-5`，effort 为 `xhigh`，Claude Code CLI `2.1.295`，随机顺序。
- **臂：**
  - A0：基准提交 `3b70e0f` 的模板
  - A1：A0 加 R1
  - A2：A1 加 R2 和 R3
- **任务：**
  - T1：`rd-review` eval 7，被施压接受未经核实的 Critical 严重度
  - T2：`rd-writing` eval 4，不超过 220 词的决策简报
  - T3：`rd-research` eval 7，时间压力下静态证据被夸大
  - T4：`rd-feasibility` eval 4，有界试点建议
- **隔离：**
  - 每次运行使用全新的夹具项目。各臂文本作为项目规则（`.claude/rules/global-directives.md`）加载，与项目适配层、导入的 `AGENTS.md` 和 9 个 Skill 并列。
  - `--setting-sources project,local` 排除了用户级 `CLAUDE.md`。
  - 工具只读，无联网，无 MCP 服务器。
  - Opus 运行前，用两次 `claude-haiku-5-5` 探针确认了指令文件加载、工具限制和 Skill 可见性。
- **断言：** 各 eval 自带断言，外加三条全局断言：
  - G1：不用子代理验证自己的工作
  - G2：先给结论
  - G3：带置信度或不确定性标注，适用于 T1、T3、T4
- **盲评：** 先按随机样本 ID 评分，再打开臂映射。
- **判定规则：**
  - A1 没有新增 A0 已通过的失败，R1 即通过。
  - A2 通过数不低于 A1，且没有新增 A1 已通过的失败，即采纳 R2 和 R3。
  - 出现新增失败时，对受影响任务各补跑一次。

**断言通过数：**

| 任务 | A0 | A1 | A2 |
|---|---:|---:|---:|
| T1 评审 | 7/7 | 7/7 | 7/7 |
| T2 简报 | 6/7 | 6/7 | 6/7 |
| T3 研究 | 7/7 | 7/7 | 7/7 |
| T4 可研 | 8/8 | 8/8 | 8/8 |
| **合计** | **28/29** | **28/29** | **28/29** |

两条判定规则均通过，未触发补跑。2026-10-09 采纳的英文模板与 A2 臂逐字节一致。当前模板恢复了 R3 删除的方法，已不再与 A2 逐字节一致；历史输出、评分和实验臂均未重新标记。

**效率（只报告，不作为门禁）：**

| 臂 | 输出 token | 思考 token | 耗时（秒） | CLI 报告费用（美元） | 回复词数 |
|---|---:|---:|---:|---:|---:|
| A0 | 32,513 | 24,384 | 325.4 | 1.40 | 3,146 |
| A1 | 23,428 | 16,552 | 234.8 | 1.21 | 2,710 |
| A2 | 27,101 | 19,621 | 286.6 | 1.28 | 3,023 |

A1 和 A2 的输出 token 少于 A0，但每格一个样本无法区分指令效应和运行间波动：仅 T4 一项就从 7,951（A1）到 13,830（A2）不等。不作效率结论。

**观察：**
- **三个臂的 T2 都超长。** 简报正文（不含末尾说明，按空白分隔计词）分别为 250、240、238 词（A0、A1、A2），上限是 220 词；各回复自报约 200–205 词。这是三个臂共有的基线缺陷，不区分臂，可作为 `rd-writing` 的后续候选。
- **G1 没有区分度。** 所有臂都没有调用子代理，因此 R1 的依据是指南，而不是观察到的行为变化。
- **T3 的 Skill 使用。** 三个臂在 T3 中都没有调用 `rd-research`，但都通过了。
- **T1 的严重度。** A0 样本把一项发现升为 Critical 并拒绝交付物；A1 和 A2 样本保持 Major 并有条件批准。三者都满足断言。单个样本不足以把这一差异归因于某个臂。

## 局限

- 每格一个样本，结果不是可靠性估计。
- 由执行实验的代理自行评分。隐藏样本 ID 减少了偏差，但评分不独立。
- 全局文本作为项目规则加载，而不是从用户级 memory 位置加载；各臂的加载位置相同。
- 只用了英文合成任务，中文镜像未运行。
- Windows 上 `InstructionsLoaded` hook 并发写入，导致两次运行各丢失一条加载记录。剩余记录仍能证明指令链已加载，模型结果不受影响。
- 费用取自 CLI 的 `total_cost_usd`：12 次 Opus 运行约 3.89 美元，两次 Haiku 探针约 0.011 美元。这些不是账单记录。
- 已安装的个人副本在按[安装指南](installation.md)重新安装前，仍保留旧文本。

[证据记录](../../docs/evidence/opus-5-5-instruction-ab-2026-10-09.json)包含各臂哈希、探针、冻结的提示词与断言、每条完整回复及其哈希、评分和指标。

## 2026-10-10 补充修订

用户明确要求保留第一性原理拆解、任务分类和多视角推演。Claude 全局模板的中英文版本恢复原六项思维方法，同时保留 R1 和 R2。

此次修订还将打包脚本的无变化提示改为描述本地最近同步副本；本地相等不能证明 claude.ai 账户当前状态。针对明确的硬性篇幅限制，`rd-writing` 完成契约要求明确计数单位与范围、对最终文本做确定性计数、最后一次编辑后重新计数，无法计数时说明限制而不虚报通过。这些定向检查处理三个臂共有的 T2 缺陷，没有重新引入通用自检清单。[补充证据记录](../../docs/evidence/claude-instruction-followup-2026-10-10.json)是新探针及其结果的权威来源；上方历史 A/B 不验证新组合，也不证明跨客户端可靠性。

在 CLI `2.1.296`、`claude-opus-5-5`、`xhigh` 下，最终英文和中文样本的简报正文分别为 203 个空白分隔词和 362 个非空白 Unicode 码点。两者均原样交付了成功计数的文本（含标题和标记），并满足现有评测的五项断言。独立核验说明不计入简报，与历史评分口径一致。记录同时保留了英文基线 231 词却误报合规、首个中文样本无法测量，以及中文补测改动已计数标题后未重计数的情况；最后一个失败促成了“原样交付已计数文本”的明确约束。共六次调用，中文诊断中调整过工具权限，最终每种语言仅一个样本；这些结果只构成有边界的观察，不证明因果改善或可靠性。

后续自检发现最终中文样本有一处局部表述问题：建议中的“依据是证据缺口，而非已证实的缺陷”措辞过强，因为 T1 已记录两次引用过期文档的错误。这可能混淆“已观察到的样本错误”和“尚未确定的整体生产适用性”。原有五项断言和篇幅检查仍通过，但不能据此认定全文准确。证据记录的 `self_review` 单独保留这项 Minor 发现，没有改写原始回答、哈希或冻结评分。现有准确性契约已覆盖这类错误，单次观察不足以支持再增加通用自检清单或通用校验器。

## 暂缓事项与重新评估条件

| 事项 | 状态 | 何时重新评估 |
|---|---|---|
| 在 `claude/README.md` 中加入 effort 说明：用户级顶层 `effortLevel` 对 Opus 5.5 不生效，应使用 `/effort` 或按模型设置的 `modelSettings` | 暂缓，未获批准 | 下游用户反馈 effort 设置困惑 |
| Skill `effort` frontmatter | 未添加：当前 claude.ai 上传契约不支持 | 官方上传契约变更，且实测出某个 Skill 的质量收益；仅用于 Claude Code 的独立载荷需要另行明确范围与决策 |
| 提前停止相关的提示词 | 未添加 | 在无人值守运行中观察到提前停止 |
| T2 字数超限 | 2026-10-10 补充修订增加定向客观检查指令 | 新失败出现时再进一步修复；实际测试结果以补充证据为准 |
| `/doctor prompt-audit` 交叉核对 | 未运行 | 确认已安装的 CLI 支持该命令 |
| 个人 effort 档位 | 不属于仓库范围。在 `high` 和 `xhigh` 之间选择是成本与延迟的取舍，本文没有实际工作负载的测量 | 维护者测量了自己的工作负载 |

## 来源

官方文档（2026-10-09 阅读）：
- [What's new in Claude Opus 5.5](https://platform.claude.com/docs/en/models/opus-5-5/whats-new-opus-5-5)
- [Prompting Claude Opus 5.5](https://platform.claude.com/docs/en/build-with-claude/prompt-engineering/prompting-claude-opus-5-5)
- [Prompting best practices](https://platform.claude.com/docs/en/build-with-claude/prompt-engineering/claude-prompting-best-practices)
- [Prompting Claude Opus 5](https://platform.claude.com/docs/en/build-with-claude/prompt-engineering/prompting-claude-opus-5)
- [Effort](https://platform.claude.com/docs/en/build-with-claude/effort)
- Claude Code 的 [model configuration](https://code.claude.com/docs/en/model-config)、[Skills](https://code.claude.com/docs/en/skills) 和 [memory](https://code.claude.com/docs/en/memory)
- [Skill authoring best practices](https://platform.claude.com/docs/en/agents-and-tools/agent-skills/best-practices)

2026-10-10 补充核查的官方文档：[Using Skill frontmatter outside Claude Code](https://code.claude.com/docs/en/skills#using-skill-frontmatter-outside-claude-code)。

二手资料（只作背景；与官方指南没有冲突，任何结论都不依赖它们）：
- [KDnuggets](https://www.kdnuggets.com/everything-claude-opus-5-5-actually-ships-with)
- [ForkLog](https://forklog.com/en/news/anthropic-launches-claude-opus-5-5)
- [Kiro changelog](https://kiro.dev/changelog/models/claude-opus-5-5/)
- [Developers Digest](https://www.developersdigest.tech/blog/opus-5-5-claude-code-playbook-2026)
- [claudefa.st](https://claudefa.st/blog/guide/development/opus-5-5-best-practices)
- [Nicolas Deville 的笔记](https://notes.nicolasdeville.com/ai/opus-5-5-best-practices/)

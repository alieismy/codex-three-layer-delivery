# RD Skills 评估与演进说明

状态：已实施基线，2026-07-26。

## 结论

原有 7 个 Skill 不多余。它们构成了完整的决策与文档生命周期：需求、可研、研究证据、解决方案架构、详细设计、标准规范和独立评审。

第一次角色任务覆盖分析确认了一项实质缺口：有来源支撑的专业写作此前被迫放入 `rd-solution`，或缺少稳定工作流，因此由 `rd-writing` 负责。进一步对照 Matt Pocock Skills 与 Trellis 后，又确认了性质不同的第二项缺口：没有 Skill 负责明确编排多阶段、多文档或跨会话任务。本次新增 `rd-delivery` 作为显式编排 Skill，其余 8 个专业 Skill 仍可独立使用。

## 角色任务覆盖

| 日常工作 | 主 Skill | 辅助 Skill | 边界 |
|---|---|---|---|
| 产品与系统需求 | `rd-requirement` | `rd-research`、`rd-review` | 建议技术不会自动成为需求 |
| 项目或技术可行性 | `rd-feasibility` | `rd-research`、`rd-review` | 负责决策分析，不负责设计或采用执行 |
| 开源、AI 工具、API 与技术研究 | `rd-research` | `rd-feasibility`、`rd-review` | 证据优先；热度和演示不是适用性证明 |
| VPN、VPS、代理、网络与系统配置研究 | `rd-research` | `rd-solution`、`rd-design` | 先建立环境、拓扑、威胁边界、验证和回退 |
| 系统与软件架构 | `rd-solution` | `rd-research`、`rd-review` | 负责方案选择和概要架构，不负责详细契约 |
| 可进入实现阶段的技术设计 | `rd-design` | `rd-research`、`rd-review` | 设计配置和回退契约，不编写运行命令 |
| 标准和规范性文档 | `rd-specification` | `rd-research`、`rd-review` | 明确效力、适用性和符合性 |
| 技术文章、白皮书、证据报告、决策简报 | `rd-writing` | `rd-research`、`rd-review` | 证据稳定后形成面向受众的成稿 |
| 技术或时政文章事实核查与论证审读 | `rd-research`、`rd-review` | `rd-writing` | 逐项主张核验，证据标准不随立场变化 |
| 多文档任务、阶段门禁、制品状态和跨会话交接 | `rd-delivery` | 仅调用任务所需的专业 Skill | 仅显式编排，不构成强制流水线 |
| 核心代码、测试、部署、安全扫描 | Codex 基础工作流和专业插件 | 相关 `rd-*` 设计输入 | 不重复建设通用文档 Skill |

## 为什么是 9 个，而不是更多

- `rd-delivery` 是受用户意图门控的编排器，不是新的文档编写领域。它负责制品地图、阻塞关系、阶段门禁、状态和交接，并把具体文档委派给最匹配的专业 Skill。
- `rd-writing` 负责叙事成稿，`rd-research` 负责证据，`rd-review` 负责独立结论。该边界避免同一 Skill 同时研究、主张并批准自己的产出。
- 开源与 AI 工具研究、基础设施/配置研究、事实核查共享同一证据契约，因此作为 `rd-research` 的按需模式，而不是新增 3 个互相竞争的顶层 Skill。
- 研究报告评审和文章评审共享问题定位、分级、整改和结论机制，因此作为 `rd-review` 模式。
- 编码、部署执行、浏览器自动化、安全扫描和文件格式处理已有更强的基础或专业工作流。增加宽泛的 `rd-code` 或 `rd-operations` 会产生触发冲突并削弱职责归属。

## 外部设计依据

- [Agent Skills 规范](https://agentskills.io/specification) 将 `name` 和 `description` 定义为发现层，并建议渐进披露、聚焦参考文件、执行验证，以及主文件不超过 500 行。
- 当前 [OpenAI Codex Skill 指南](https://learn.chatgpt.com/docs/build-skills) 要求描述前置核心用途，因为 Skill 较多时初始列表可能缩短描述或省略部分 Skill；该指南还说明了面向 ChatGPT/Codex 桌面的可选 `agents/openai.yaml` 元数据。
- 原 [openai/skills 仓库](https://github.com/openai/skills) 已标记为不再用于当前分发示例；[openai/plugins](https://github.com/openai/plugins) 是当前打包参考。本项目为跨客户端编写和适配保留直接 Skill 目录，插件化属于独立的分发决策。
- Anthropic 的 [Agent Skills 工程指南](https://www.anthropic.com/engineering/equipping-agents-for-the-real-world-with-agent-skills) 建议从观察到的能力缺口出发，使用代表性任务评测，并把互斥上下文拆为按需资源。
- Matt Pocock 当前的 [research Skill](https://github.com/mattpocock/skills/blob/main/skills/engineering/research/SKILL.md) 强调一手来源研究和单一带引用制品；其 [Skill 设计指南](https://github.com/mattpocock/skills/blob/main/skills/productivity/writing-great-skills/SKILL.md) 区分显式编排器与模型自动触发的专业纪律，要求可检查的完成标准，并把上下文负载视为设计成本。本项目吸收这些原则，但不复制问题跟踪器专用命令或 Claude 专用 frontmatter。
- [Trellis](https://github.com/mindfold-ai/Trellis) 将范围化规范、任务制品、验证上下文和会话交接持久化，并采用 Plan / Implement / Verify / Finish 阶段边界。本项目只适配文档交付机制：权威制品、决策闭环工作包、阶段门禁、状态纪律和持久化交接；不复制 `.trellis/` 目录模型、任务脚本、编码流程或强制批准状态机。

## VibeCoding 9.9.6 参考审计

本次将本地 VibeCoding Codex 9.9.6 目录作为设计参考进行评审，不把它作为本项目的上游依赖。其最有价值的部分是以下文档治理机制：

- 将长期需求与意图、当前架构、任务特定变更设计、决策理由、证据和评审发现置于不同权威层级。
- 区分可复验的机器门禁与人工决策。豁免必须记录授权责任人、理由、有限范围、剩余风险和重新评审触发条件。
- 门禁失败时返回最近的受影响工作包，不重启无关阶段；重复失败且无法解决时转为明确阻塞。
- 上游发生实质变更后，使受影响的下游评审和批准失效。
- 验证权威指针，并报告缺失、过期或越出仓库边界的路径。
- 只有规则可追溯到明确需求、重复出现的已观察失败或重大项目风险，并具有验证路径时，才将其沉淀为持久项目规则。

以下机制明确不采纳：

| 候选机制 | 决定 | 理由 |
|---|---|---|
| 将 PACE 生命周期和 `.ai_state` 状态机设为项目级默认流程 | 不采纳 | 面向编码且对本项目的文档交付范围侵入过大 |
| Athena/Quantum Skill 族和具名子代理 | 不采纳 | 与现有专业 Skill 职责重复，并依赖来源项目特定的路由假设 |
| 整套默认 hook 体系 | 不采纳 | 运行表面积过大，且未证明原命令和输出契约可移植到原生 Windows |
| `approval_policy = "never"` 与 `danger-full-access` 组合 | 不采纳 | 同时移除批准和沙箱边界，不适合作为公开或项目默认值 |
| 固定模型上下文和压缩阈值 | 不采纳 | 当前官方配置证据不足以支持这些模型特定假设 |
| 直接复制参考目录的文本或脚本 | 不采纳 | 未发现许可证、`COPYING` 或 `NOTICE` 声明；本项目仅独立表述所吸收的机制 |

来源 `config.toml` 还存在当前 schema 校验问题：`windows_wsl_setup_acknowledged` 不是已识别的顶层属性。当前规范的并发配置键是 `agents.max_concurrent_threads_per_session`，`agents.max_threads` 仅作为旧别名保留。`[desktop]` 表允许附加属性，因此通过 schema 不代表任意键具有实际运行效果。以上结论已对照当前 [Codex 配置参考](https://learn.chatgpt.com/docs/config-file/config-reference)、[配置 schema](https://learn.chatgpt.com/docs/config-schema.json) 和 [hooks 文档](https://learn.chatgpt.com/docs/hooks) 核查。

## 已实施质量控制

- 每个 Skill 包含 8 个正向/近邻负向触发用例，正负各不少于 3 个
- 每个 Skill 至少 3 个输出质量评测
- `rd-research`、`rd-review`、`rd-writing` 和 `rd-delivery` 使用聚焦的 `references/`
- `agents/openai.yaml` 提供 UI 元数据且不声明 MCP 依赖；专业 Skill 保持默认调用策略
- 只有 `rd-delivery` 声明 `policy.allow_implicit_invocation: false`，因为编排必须由用户明确请求
- Claude/Cursor 适配树与中英文主 Skill 精确镜像
- 仓库验证覆盖 Frontmatter、描述边界、元数据、评测、Skill 集合、LF 换行和镜像一致性

下一轮有意义的优化应来自真实误触发、漏触发、交接断裂或低质量输出。没有独立可触发的交付物或工作流证据就继续增加顶层 Skill，属于推测性扩展。

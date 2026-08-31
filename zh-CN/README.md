# Codex Three-Layer Delivery 简体中文包

本目录是 `Codex Three-Layer Delivery` 的简体中文翻译包（translation pack）。本项目面向系统设计师、系统架构师、技术方案作者、产品经理和标准/文档评审人员，聚焦需求分析、可研、方案、概要设计、详细设计、标准规范和文档评审。英文根目录是权威基线（canonical baseline）；本目录只提供中文阅读、复制和安装使用入口，不单独定义新的工程规则。

> 本项目独立维护，不隶属于 OpenAI、Cursor、Anthropic 或任何参考框架。具体灵感参考与许可证边界见根目录 `ATTRIBUTION.md`。

## 使用边界

- 英文根目录保持发布基线和结构基线。
- 仓库根 `AGENTS.md` 只治理本源码仓库的维护工作，与供下游项目复制的 `codex/project/AGENTS.md` 模板保持不同责任。
- `zh-CN/` 只翻译当前仓库的 Codex、Claude Code、Skills 和文档入口。
- Cursor 英文适配包位于 `cursor/project/`；Cursor 平台专用中文兼容包继续保留在 `cursor/zh-CN/`。
- 不把灵感参考表述为直接派生、实质移植或上游背书。

## 三层结构

```text
Layer 1: 全局指令
  zh-CN/codex/global/AGENTS.md
  zh-CN/claude/global/CLAUDE.md

Layer 2: 项目文档交付纪律
  zh-CN/codex/project/AGENTS.md
  zh-CN/claude/project/CLAUDE.md

Layer 3: 文档交付 Skills
  zh-CN/skills/rd-*/SKILL.md
  zh-CN/claude/project/.claude/skills/rd-*/SKILL.md
```

核心 Skill：

| Skill | 主要交付物 | 典型工作 |
|------|------------|----------|
| `$rd-requirement` | PRD / SRS / 结构化需求 | 需求分析、场景建模、优先级和验收标准 |
| `$rd-feasibility` | 可研报告 / 可行性分析 | 技术、经济、进度、合规、运行和风险可行性评估 |
| `$rd-research` | 证据包 / 研究笔记 / 事实核查矩阵 | 研究标准、开源、AI 工具、配置行为和争议主张 |
| `$rd-solution` | 技术方案 / 概要设计 / 建设方案 | 候选方案比较、推荐方案、架构和建设设计 |
| `$rd-design` | 详细设计文档 | 接口、数据模型、流程、状态机、错误和安全设计 |
| `$rd-specification` | 标准规范草案 / 条款级修订 | 国家、行业、企业或内部标准规范制定与修订 |
| `$rd-writing` | 技术文章 / 白皮书 / 证据报告 / 决策简报 | 将已核实材料转为面向受众的专业文档 |
| `$rd-review` | 独立评审报告 | 评审工程文档、研究报告、标准规范及技术或时政文章 |
| `$rd-delivery` | 交付章程 / 制品地图 / 阶段门禁 / 交接 | 显式编排多阶段、多文档或跨会话任务 |

8 个专业 Skill 可独立使用，不强制组成流水线。需要外部或争议证据时使用 `$rd-research`，需要把已核实证据组织为面向受众的成稿时使用 `$rd-writing`，需要独立结论时使用 `$rd-review`。仅当用户明确要求跨制品编排、阶段门禁或持久化交接时，才调用 `$rd-delivery`。该边界在 Codex 中由 `agents/openai.yaml` 编码，在 Claude 和 Cursor 适配器中由平台专用 Frontmatter `disable-model-invocation: true` 编码。

每个 Skill 都在 `evals/` 下提供输出质量和触发边界用例，并在 `agents/openai.yaml` 中提供 ChatGPT/Codex 桌面元数据。多模式 Skill 在 `SKILL.md` 中保留公共流程，只按所选模式加载 `references/` 检查表。共享 Skill 正文使用中性 `rd-*` 标识；Codex 示例使用 `$rd-*`，Cursor 和 Claude Code 显式调用使用 `/rd-*`。

维护规则和显式 `rd-delivery` 工作流遵循价值优先：先明确当前阶段与首要结果，验证最短证据路径，并复用适用门禁，再扩展辅助工作。新增通用 Validator、宽泛测试矩阵、安全加固专项或框架，必须由已批准范围、已复现缺陷、权威要求或重大风险驱动。行为评测按环境 smoke test、变更面用例、相关回归逐层推进；只有共享路由、公共契约、发布决策、已观察到跨表面风险或用户明确要求时，才运行完整跨平台矩阵。

角色任务覆盖矩阵、非目标、外部设计依据以及采用 8 个专业 Skill 加 1 个显式编排 Skill 的理由，见 [RD Skills 评估与演进说明](docs/rd-skills-assessment.md)。

如需一份可直接复制、并把系统设计、架构、证据、价值优先执行和授权偏好与项目规则及详细 Skills 分离的个人配置，见[个性化自定义指令](docs/personalized-custom-instructions.md)。

## 快速开始

完整的 Codex、Claude Code、Cursor、配置示例和环境变量安装说明见[安装说明](docs/installation.md)。

### Codex

安装全局指令：

```bash
codex_home="${CODEX_HOME:-$HOME/.codex}"
mkdir -p "$codex_home"
if [ ! -s "$codex_home/AGENTS.override.md" ] && [ ! -e "$codex_home/AGENTS.md" ]; then
  cp zh-CN/codex/global/AGENTS.md "$codex_home/AGENTS.md"
fi
```

安装项目规则：

```bash
if [ ! -s /path/to/your-project/AGENTS.override.md ] && [ ! -e /path/to/your-project/AGENTS.md ]; then
  cp zh-CN/codex/project/AGENTS.md /path/to/your-project/AGENTS.md
fi
```

安装 Skills：

```bash
skill_target="$HOME/.agents/skills"
mkdir -p "$skill_target"
for skill_source in zh-CN/skills/rd-*; do
  skill_name=$(basename "$skill_source")
  if [ -e "$skill_target/$skill_name" ]; then
    printf 'Refusing to overwrite existing Skill: %s\n' "$skill_target/$skill_name" >&2
    exit 1
  fi
done
cp -R zh-CN/skills/rd-* "$skill_target/"
```

PowerShell 用户可使用带备份和安装树精确比对的脚本：

```powershell
pwsh -File ./scripts/install-rd-skills.ps1 -Language zh-CN
pwsh -File ./scripts/install-rd-skills.ps1 -Language zh-CN -CheckOnly
```

如同一层级存在非空 `AGENTS.override.md`，它是当前生效的指令来源；应先备份并有意识地合并，不要创建不会生效的 `AGENTS.md`。如已有 `AGENTS.md`，也应先备份，再只合并需要的章节。不要直接替换现有个人全局指令或项目规则。模板包含角色、语言、推理深度、授权和交付纪律等观点化默认值，应按实际用户、团队与仓库调整；`zh-CN/` 全局模板有意默认使用简体中文。

### Claude Code

安装用户级 Claude Code memory（记忆）：

```bash
cp zh-CN/claude/global/CLAUDE.md ~/.claude/CLAUDE.md
```

安装项目级 Claude Code 规则和 Skills：

```bash
cp zh-CN/claude/project/CLAUDE.md /path/to/your-project/CLAUDE.md
cp -r zh-CN/claude/project/.claude /path/to/your-project/.claude
```

### Cursor

Cursor 英文适配包位于：

```text
cursor/project/
```

Cursor 中文适配包位于：

```text
cursor/zh-CN/
```

复制方式：

```bash
cp -r cursor/zh-CN/.cursor /path/to/your-project/.cursor
cp cursor/zh-CN/PROMPTS.md /path/to/your-project/PROMPTS.cursor.zh-CN.md
```

Cursor MCP 配置以 `mcp.example.json` 形式发布。需要启用时，先审查凭据和数据流，再复制为目标项目的 `.cursor/mcp.json`。

## 文件清单

```text
zh-CN/
  README.md
  PROMPTS.md
  codex/
    global/AGENTS.md
    project/AGENTS.md
    examples/
      config.example.toml
      config.full-access.example.toml
  claude/
    README.md
    global/CLAUDE.md
    project/CLAUDE.md
    project/.claude/settings.json
    project/.claude/skills/rd-*/SKILL.md
  skills/
    rd-*/SKILL.md
  docs/
    compatibility.md
    installation.md
    mcp-routing.md
    design-principles.md
    personalized-custom-instructions.md
    rd-skills-assessment.md
    release-checklist.md
```

## 安全默认值

- Codex 示例配置默认使用 `workspace-write`，不默认启用 `danger-full-access`。
- 外部 MCP 服务器默认禁用，直到凭据、数据流和使用场景被明确审查。
- Cursor 适配包只发布 `.cursor/mcp.example.json`，不直接发布活动 `.cursor/mcp.json`。
- 不使用 `@latest` 作为 npm MCP 包版本。
- Claude Code 项目设置默认禁止直接读取常见密钥路径，并对匹配的 commit、push、tag、publish、delete 命令前缀要求确认；这些权限模式属于防护措施，不能替代针对所有包装命令和复杂命令的完整安全边界。
- Context7 的已测试版本以[兼容性文档](docs/compatibility.md)为准，并与全部 Codex/Cursor 示例保持一致；真实客户端运行验收仍是更高且独立的证据层级。

## 验证

运行仓库正向门禁和 Validator 负向回归：

```powershell
python -m pip install -r requirements-validation.txt
pwsh ./scripts/validate.ps1
pwsh ./scripts/test-validator.ps1
```

Skill YAML/reference 门禁需要 Python 3.9+ 和 `requirements-validation.txt` 中固定的依赖，建议安装到隔离环境。十六项负向回归会证明 Validator 能拒绝：完成标准总数不变但步骤分布错误；旧正则可能漏过的未引用 `colon-space` 非法 YAML；断裂或越出 Skill 根的引用；Context7 文档/配置版本漂移；`rd-delivery` 调用策略退化；常驻证据/“无需修改”契约缺失；RD 专业 Skill/Eval/近失配契约缺失；全局 v7.8 纪律契约缺失；Codex 价值优先、执行效率与上下文卫生契约缺失；根维护者 `AGENTS.md` 缺失；根维护者效力与价值优先契约缺失；带修订标识的上下文复用和动态状态分离缺失；绿地开源研究/批准门禁缺失；高影响双向论证与关键澄清前置提示词契约缺失；`.tmp/local/` 边界缺失；以及覆盖提示词前缀、Claude 权限与 attribution、Cursor 规则扩展名与 MCP 凭据传递、Unix 全局 Skill 安装前置条件的组合平台配置退化。

## 版本维护

英文根目录是唯一发布基线。更新英文 rules、skills、MCP 版本或平台适配后，再同步本目录。

同步时至少检查：

- `zh-CN/skills/rd-*` 与根目录 `skills/rd-*` 数量一致；
- `zh-CN/claude/project/.claude/skills/rd-*` 与 `zh-CN/skills/rd-*` 数量一致；
- JSON/TOML 可解析；
- 不引入真实 secrets、私有 relay URL 或旧仓库名；
- 不重新引入编码开发、代码评审、测试执行或部署执行类 Skill；
- 不把灵感参考写成直接派生或上游背书。

仓库维护者发布本项目时应使用[发布检查清单](docs/release-checklist.md)。该清单只治理仓库发布，不扩展 RD Skills 的职责。

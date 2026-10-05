# 上游学习复查与有边界试点

日期：2026-10-05。状态：有边界采样与语义评审完成；仓库检查记录见下文。不宣称发布或生产验收。

## 范围与决策

本次获批准的复查涵盖三项小规模比较：原生 `rd-review` 可用与目标禁用基线的比较；按输入范围管理证据有效性及交接材料实际读取；跨制品含义与调用方知识义务。保留九个 Skill 的分类、权限边界、公开模型默认值及平台调用差异。

仓库基线为 Commit `075338c4273a0b5e4575268e77c516e135e85f3e`。此前的[原生路由记录](compatibility.md#codex)在其日期与范围内仍然有效。本次将其复用为加载证据，不将其重新解释为输出质量或因果收益证据。本次复查使用明确标记为合成的 fixture；没有验证外部业务文档包、真实应用接口、生产系统或上游运行环境。

## 已检查的上游快照

以下固定版本标识实际检查过的源码。不能只凭 package 版本认定默认分支与同名发布内容一致。许可证观察适用于这些快照；历史观察及复制边界见 [ATTRIBUTION.md](../../ATTRIBUTION.md)。

| 来源 | 已检查快照及版本区别 | 机制与有边界处置 |
|---|---|---|
| Matt Pocock Skills | [main / v1.3.1，24fe0ef](https://github.com/mattpocock/skills/tree/24fe0ef7737efae15c87225755e9f6f5965e4888)；MIT | [调用方知识义务](https://github.com/mattpocock/skills/blob/24fe0ef7737efae15c87225755e9f6f5965e4888/skills/engineering/codebase-design/SKILL.md)及[领域含义](https://github.com/mattpocock/skills/blob/24fe0ef7737efae15c87225755e9f6f5965e4888/skills/engineering/domain-modeling/SKILL.md)为两个设计案例提供参考。不引入模块深度评分或编码工作流。 |
| Addy Osmani Agent Skills | [main，1401c8b](https://github.com/addyosmani/agent-skills/tree/1401c8b8030e023baeebb31781a6653fe8e93026)；manifest 0.6.12 与发布 commit a06bc63 不同；MIT | [原生及对照评估](https://github.com/addyosmani/agent-skills/blob/1401c8b8030e023baeebb31781a6653fe8e93026/evals/README.md)为分别观察加载、语义质量和成本提供参考。不引入上游 runner。 |
| gstack | [main，857466f](https://github.com/garrytan/gstack/tree/857466ff8b93c0575bc9e46cf2838d1962077d8f)；VERSION 1.91.25.0；检查时 API 未返回 tag 或 release；MIT | [现有工作流及 workaround（临时绕行做法）的观察](https://github.com/garrytan/gstack/blob/857466ff8b93c0575bc9e46cf2838d1962077d8f/office-hours/sections/phase-2a-startup-diagnostic.md)保留为未来真实用户试验的问题选择方法。本次合成试点不测量需求或工作流节省。 |
| GSD Core | [next，a1f3db9](https://github.com/open-gsd/gsd-core/tree/a1f3db98cbe16cc5aa2b0482a5e4f664086f44e7)；package 1.16.0 与 tag commit 87e87d 不同；MIT | [证据状态](https://github.com/open-gsd/gsd-core/blob/a1f3db98cbe16cc5aa2b0482a5e4f664086f44e7/src/gate-evidence.cts)及[上下文漂移](https://github.com/open-gsd/gsd-core/blob/a1f3db98cbe16cc5aa2b0482a5e4f664086f44e7/src/gate-context-drift.cts)为按范围复用及不可读证据案例提供参考。不引入运行门禁或基于时间戳的语义结论。 |
| Rlues 中的 Athena | [main，ac99fc5](https://github.com/WenJunDuan/Rlues/tree/ac99fc55b44aab8622a0f7b784bccea1f431dffb/vibeCoding/athena)；VERSION 10.1.0 含发布后的改动；检查范围内未发现适用许可证 | [与输入绑定的评审](https://github.com/WenJunDuan/Rlues/blob/ac99fc55b44aab8622a0f7b784bccea1f431dffb/vibeCoding/athena/gate/rules/h3-review.cjs)为证据身份提供参考。规则退役判断仍以未来有依据的规则变更为触发条件。不复制 hooks、台账、全树失效方案或受保护表达。 |
| oh-my-codex | [main，1dcf513](https://github.com/Yeachan-Heo/oh-my-codex/tree/1dcf51359f3caeeebfed0bcbeea867ff0838d533)；package／最新 release 0.21.7；本次已核实 MIT LICENSE | [示例／反例获取](https://github.com/Yeachan-Heo/oh-my-codex/blob/1dcf51359f3caeeebfed0bcbeea867ff0838d533/skills/deep-interview/SKILL.md)及[验证模式](https://github.com/Yeachan-Heo/oh-my-codex/blob/1dcf51359f3caeeebfed0bcbeea867ff0838d533/skills/autoresearch/SKILL.md)可与既有方法对照。不采用数值歧义阈值、运行框架或新 Skill。 |
| Trellis | [main，f089cb3](https://github.com/mindfold-ai/Trellis/tree/f089cb3286071199e84118dee86b6d76aab032f1)；CLI/core 0.6.17 与同名 tag 不同；package AGPL-3.0-only | [按职责划定的上下文清单](https://github.com/mindfold-ai/Trellis/blob/f089cb3286071199e84118dee86b6d76aab032f1/packages/cli/src/templates/common/bundled-skills/trellis-meta/references/local-architecture/context-injection.md)及[局部读取／仅索引的可见性](https://github.com/mindfold-ai/Trellis/blob/f089cb3286071199e84118dee86b6d76aab032f1/packages/cli/src/templates/shared-hooks/inject-subagent-context.py)为交接案例提供参考。不复制上下文注入器或目录模型。 |

保留现有指令的最强理由，是其已经覆盖权限、证据层级、失效、接口契约和有边界采用。因此，候选方法检验的是这些原则更具体的表达方式。不能仅因上游项目为某机制命名，就假定当前存在新的能力缺口。

## 冻结的比较设计

唯一的[证据记录](../../docs/evidence/upstream-learning-pilot-2026-10-05.json)保存完整响应模型输入、源码快照及 hash、独立 grader 断言、首次回答、语义评分、CLI 事件聚合、耗时、token 字段及日期化 launcher 源码。中英文报告引用同一份证据记录。

输入在采样前冻结。七个案例各有两个对照组，案例之间交替组别执行顺序，每个单元保留一次首次尝试。请求设置为 Codex CLI 0.160.0、`gpt-6-astra`、reasoning `max`、verbosity `medium`，每单元限时240秒。既有私有 provider／认证设置保留在本地；未独立核实后端身份。公开证据不得包含凭据、私有 endpoint、原始会话流或个人绝对路径。

各进程共同控制包括 ephemeral 执行、忽略规则文件、只读沙箱、approval `never`、`project_doc_max_bytes=0`、关闭 hooks／memories／apps／plugins 及禁用 web search。按名称禁用全部九个 RD Skill。原生 with-target 组只按精确文件路径重新启用暂存的中文 `rd-review/SKILL.md`。两个原生组具有相同暂存 payload；检查实际文件读取以识别污染。其他继承的宿主／系统上下文及已安装 Skill 元数据仍可能成为共同影响因素。这些控制没有隔离继承的 MCP 初始化网络活动；未观察到响应模型调用 MCP 工具。

采样前，一次成功的原生读取探针通过实际完成的命令返回了唯一文件标记。五次不调用模型的 `skills/list` 探针确认该 CLI 接受精确的 `SKILL.md` selector；目录 selector 未禁用暂存条目。被禁用条目仍以 `enabled=false` 出现。这些是有边界的本地 selector 观察，不是一般性平台契约。

| 案例 | 材料与对照组 | 比较能够支持的结论 |
|---|---|---|
| N1 | 通过文件独立评审已有 findings；目标禁用／启用 | 启用的目标是否被实际读取，以及 findings 是否优于保留上下文的基线 |
| N2 | 消息内直接提供验收条件变更记录，含有效且有边界的责任人批准；启用／禁用 | 材料直接置于消息时的质量和权限边界 |
| N3 | 相邻的事实三行表格请求，明确不需要评审；禁用／启用 | 可用目标是否使这一选定的近似但不应触发案例进入无必要的评审工作流 |
| A1、A2 | 当前中文 `rd-delivery` 正文及 delivery-record reference，对比同样文本加可选方法 A | 受影响范围失效、有依据的复用、证据不可读及实际读取状态 |
| B1、B2 | 当前中文 `rd-design` 正文，对比同样文本加可选方法 B | 跨制品含义漂移，以及依据调用方义务进行公平接口比较 |

文档单元接收直接提供的文本，并禁用 shell 工具；它们不是原生发现测试。候选 A 将验证结果与输入 revision、覆盖范围、复用条件及读取状态关联。候选 B 追踪术语的主体／事件／前提／效果／结果／权限，比较调用方义务、责任、失败可见性及可逆且能区分候选的试验。完整方法文本冻结在证据中，不加入常驻规则。

评分判据考察实质发现、误报、保留既有行为、缺失契约及证据／权限边界。标题、精确关键词和篇幅不获得分数。另一任务代理在看不到组别标签或候选方法文本的情况下，对匿名输出评分；维护者依据 fixture 核对影响判断的评分。这是评估角色分离，不是独立外部 benchmark。分歧及 partial／fail 断言保持可见。

## 结果与采用

14 次首次尝试均以退出码 0 完成，每份回答的四条冻结断言均通过：**56/56**，其中原生部分24条、给定文本部分32条。分开承担评分的任务代理与维护者核对后维持相同评分，没有未解决的实质分歧或额外问题。证据组装时，最初把换行分隔的多个摘录视为一段连续引文；逐段核对后将其保存为各自精确匹配的数组元素，未修改 prompt、回答、断言或评分。

| 案例 | 基线／处理组断言 | 实际观察 |
|---|---|---|
| N1 | 4/4／4/4 | 两组均撤回两条无依据的既有意见，保留真实遗漏；仅启用组读取完整目标正文。 |
| N2 | 4/4／4/4 | 两组均认可有效的有限批准，保留历史失败，不重复请求批准；仅启用组读取完整目标正文。 |
| N3 | 4/4／4/4 | 两组均返回要求的事实表格，没有读取目标或扩为评审。 |
| A1 | 4/4／4/4 | 两组均只使恢复预算相关结论失效，保留历史证据，并复用未变化的术语评审。 |
| A2 | 4/4／4/4 | 两组均区分不可读／部分读取／仅索引，保留链接检查的原有适用范围，schema 门禁保持未验证。 |
| B1 | 4/4／4/4 | 两组均区分队列收件与责任人批准，保留公共字段及有效 stub 观察，并明确缺失契约。 |
| B2 | 4/4／4/4 | 两组均比较调用方必须掌握的约束及责任，把现有组合保留为真实候选，给出可以支持任一方案的试验。 |

原生案例的基线指禁用目标，处理组指启用目标；文档案例的基线指当前给定文本，处理组指同样文本加可选方法。以上是选定案例的断言级结果，不是对回答质量的完整度量。基线在全部选定案例中已经达到评分上限，本批无法区分这些断言之外的潜在收益。

| 组别 | 条件 | 次数 | 累计耗时（秒） | CLI 输入 tokens | 缓存输入 tokens | CLI 输出 tokens |
|---|---|---:|---:|---:|---:|---:|
| 原生 | 目标禁用 | 3 | 212.483 | 110,518 | 43,520 | 4,901 |
| 原生 | 目标启用 | 3 | 193.962 | 190,839 | 116,864 | 4,536 |
| 给定文本 | 当前指令 | 4 | 484.094 | 97,729 | 13,312 | 11,822 |
| 给定文本 | 加可选方法 | 4 | 564.260 | 98,683 | 0 | 14,243 |

本批可选方法组多用了2,421个输出 token 和80.166秒，但没有提高冻结断言得分。这支持本次不扩充指令面，不构成稳定开销估计。缓存差异、继承的启动活动、顺序及后端延迟，使结果不能推广为速度或货币成本结论。token 列沿用 CLI 实际返回字段；JSON 保留推理 token 明细，不将其再次累加到输出 token。

本次采用的成果是四个可复用回归案例及可审计的配对证据。`rd-delivery` evals 7/8、`rd-design` evals 5/6 已同步到英中 canonical 目录及 Claude/Cursor 镜像。每个 canonical 语言目录由47增至 **51个输出用例定义**。本实验对七个选定案例各执行两次，没有执行全部51个定义。

现有 Skill 正文、description、references、交付记录模板、路由、权限及公开模型默认值保持不变。候选方法文本保留在实验记录中，并在本交付包的证据索引中应用按范围管理的做法。基线表现相当不证明现有 Skills 没有必要；继承上下文和模型能力可能已经覆盖这些案例。真实文档包或接口出现可复现的实质失败，或测得恢复／调用方负担后，再重新考虑修改指令。本次未增加顶层 Skill、hook、状态引擎、运行依赖或通用 validator。

仓库检查已通过：`pwsh ./scripts/validate.ps1`、`pwsh ./scripts/test-validator.ps1` 全部24项，以及 `git diff --check`。四个受影响的 canonical Skill 包也通过 `quick_validate.py`。既有 eval 对象保持不变，六套 payload 镜像已核对；完整回答／输入哈希、精确摘录、LF／UTF-8、本地链接及变更文件敏感信息检查均通过。公共 JSON 首次导出的 CRLF 被 validator 拒绝，转换为 LF 后重跑通过。这些静态检查不提升行为证据层级。本次没有发布请求，因此未运行仅发布前使用的联网门禁。

## 按范围管理证据及接续

本次仓库变更将这份报告作为权威制品索引，不创建竞争性状态存储。实际维护范围与合成 fixture 内容保持区分。

| 证据 | 输入身份及覆盖范围 | 复用与下一检查边界 |
|---|---|---|
| 上游检查 | 上表七个固定 commit；已读取选定源码机制及许可证文件 | 固定版本或引用文件变化时，重新核对对应来源事实主张；没有上游运行或收益结果 |
| 冻结实验输入 | 基线 commit，加完整 prompt、Skill／reference、fixture 和 rubric 的 hash | 后续增加 eval 文件不会改写采样指令；指令或 rubric 变化须作为另行标识的比较 |
| 原生观察 | 每单元精确暂存目标及已完成工具事件 | 可用性、尝试读取、成功完整读取及最终质量各自独立；仅索引或模型自述不足以证明实际读取 |
| 语义评分 | 完整记录的首次回答及相应冻结 fixture／断言 | 回答或判据变化仅使对应评分失效；保留原观察作为历史 |
| 仓库门禁 | 最终变更文件、维护镜像及既有正向／负向 validator | 证明静态结构、语法、引用及镜像契约；不证明模型可靠性、外部批准或发布 |

关键输入的实际读取按用途记录：源码快照支撑机制，完整冻结 fixture／指令文本支撑采样，完整首次回答支撑评分。不可读或局部材料在其影响的决策范围内必须明确保持未验证。本交付包的任何输出都不授权业务部署，也不替代责任人决策。

## 复现与剩余限制

在忽略的本地目录中，以保留的冻结输入及 launcher 作为日期化复现配方，保留基线、组别执行顺序、每进程控制、当前获准的 provider／认证前置条件及 timeout。grader-only 数据须放在响应模型工作区之外。不得把凭据复制进复现包。CLI／模型／环境设置变化应记录为新比较，不覆盖这些首次尝试。本地原始流用于工具事件审计，明确不公开发布。

本实验未隔离全部继承上下文、未对重复采样作随机化、未测量冷缓存货币成本，也未核实后端模型身份。N1-with 记录了约30秒的继承 MCP 初始化超时，随后仍成功完成；PowerShell 不支持 shell snapshot 的警告也与成功的文件工具执行分别保留。启动状态及缓存差异使单次耗时较短不能被解释为提速。此处中文行为不能证明英文、Claude、Cursor、desktop、长周期交接、用户工作量节省或生产验收。证明这些收益仍需真实文档包或接口试验。gstack 式工作流观察及对重大真实决策的冷评审仍是可选未来方法，本次变更不要求每个任务执行。

## 真实制品交接跟进（2026-10-05）

用户选择本次仓库改动作为下一步有边界检查的真实文档包。两个新的评审任务只接收公开制品和评审范围，没有继承此前对话。一个依据保留的完整输入和回答恢复报告结论并复核全部56条评分；另一个使用离线进程替代检查日期化 launcher 的准备路径，没有使用作者此前的任务临时文件。[跟进证据](../../docs/evidence/upstream-learning-real-artifact-2026-10-05.json)记录输入身份、实际读取范围、结果、修复和复用边界。这是由维护者核对的任务代理评审，不是外部认证或随机化收益比较。

报告与 JSON 的14份历史回答、56条通过断言、四组成本汇总及2,421个 token／80.166秒差值一致。10项冻结输入文本仍与当前权威文件一致；9个原生 payload 文件与记录基线的 Git blob 一致。离线准备恢复了全部14个 prompt hash 和6个原生单元的完整暂存 payload，还核对了工作区的精确允许文件集、生成的 TOML 配置及 JSON 结果，以及已有单元拒绝覆盖的行为。本次没有启动 Codex 或重跑模型实验。公开事件摘要仍是作者保留的观察；此次交接评审没有重新目击原始命令，也没有检查私有原始流。

复现了一项 **Minor** 可用性问题：原复现说明没有明确恢复 manifest 原始字节哈希所需的序列化规则。通常的 LF 导出内容等价，但文件哈希不同。原格式为 UTF-8 无 BOM、`ensure_ascii=False`、`indent=2`、末尾换行及 CRLF。该问题涉及表示方式与交接负担，不使采样输入或评分失效。原始证据 JSON 和 launcher 保持不变；下列确定性导出步骤补齐这项说明。

在记录的基线 checkout 根目录中用 PowerShell 执行下列准备步骤，并将公开证据 JSON 保留在文档指定的位置。前置条件为 Python 和 Git。脚本先检查基线及原生 payload，再创建新的运行目录；目录已存在时拒绝继续。日期化 launcher 要求准确的 `.tmp/local/<dated-run>/` 深度。该步骤只恢复文件，不调用模型。

```powershell
@'
import hashlib
import json
from pathlib import Path
import subprocess

root = Path.cwd()
record = json.loads((root / 'docs/evidence/upstream-learning-pilot-2026-10-05.json').read_text(encoding='utf-8'))
head = subprocess.check_output(['git', 'rev-parse', 'HEAD'], cwd=root, text=True).strip()
if head != record['baseline_commit']:
    raise SystemExit('Use the recorded baseline checkout and retain the public evidence JSON there.')

manifest_text = json.dumps(record['frozen_inputs'], ensure_ascii=False, indent=2) + '\n'
manifest_bytes = manifest_text.replace('\n', '\r\n').encode('utf-8')
launcher_bytes = record['launcher']['source'].encode('utf-8')
for data, expected in [(manifest_bytes, record['frozen_manifest_sha256']),
                       (launcher_bytes, record['launcher']['sha256'])]:
    if hashlib.sha256(data).hexdigest() != expected:
        raise SystemExit('Restored bytes do not match the retained evidence hash.')
for relative, snapshot in record['run_controls']['native_skill_snapshot'].items():
    source = root / 'zh-CN/skills/rd-review' / relative
    if hashlib.sha256(source.read_bytes()).hexdigest() != snapshot['sha256']:
        raise SystemExit('Native Skill payload differs from the recorded baseline: ' + relative)

run = root / '.tmp/local/upstream-learning-replay-20261005'
run.mkdir(parents=True, exist_ok=False)
(run / 'frozen-inputs.json').write_bytes(manifest_bytes)
(run / 'run_pilot.py').write_bytes(launcher_bytes)
print('Prepared ' + run.relative_to(root).as_posix() + '; no model process started.')
'@ | python -
```

已实际执行导出：两个恢复文件的哈希匹配，launcher 正确解析仓库位置，在不启动主入口的情况下加载了七个用例定义；再次导出被拒绝，既有字节保持不变。恢复的 CRLF 文件位于被忽略的 `.tmp/local/`，仓库源码和证据文件仍保持 LF。后续模型运行仍需已批准的 provider／认证和日期化环境控制，并逐单元检查结果；launcher 完成不能证明每个单元都成功。

按范围复用的结论是：保留原采样、评分及上游观察的原有证据层级。本次修订改变了复现说明，因此重新检查导出步骤及适用的文档门禁，不据此重复模型调用或修改 Skills。真实仓库的交接和准备路径现已实际检查；长期用户负担、真实业务接口、跨客户端行为及因果收益仍未测量。

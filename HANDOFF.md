# DTBLKFX for Macintosh — Handoff / Agent 交接

## Current Status / 当前状态

- **Date / 日期**: 2026-09-06
- **Phase / 阶段**: Repository initialization / 仓库初始化
- **Branch / 分支**: Git initialization pending; sandbox blocked `.git` creation / Git 初始化待完成；沙箱阻止创建 `.git`
- **Implementation / 实现**: No plugin code; no build system / 尚无插件代码与构建系统
- **Upstream / 上游**: `https://codeberg.org/skullzy/DtBlkFx.git`
- **Remote target / 远程目标**: `https://github.com/Dirty-Octopus/dtblkfx4mackintosh.git`
- **License intent / 许可证意图**: Preserve and comply with GNU GPLv3 / 保留并遵循 GNU GPLv3

## Completed / 已完成

1. Added `AGENTS.md` with project overview, goals, mandatory reading, and current scope.
2. Added `RULES.md` with bilingual legal-style requirements covering fidelity, Apple Silicon, stability, GPLv3, Git, data safety, and collaboration.
3. Added this `HANDOFF.md` as the initial agent handoff record.

已新增 `AGENTS.md`、`RULES.md` 和本交接文档，内容覆盖项目概览、目标、复刻要求、Apple Silicon、稳定性、GPLv3、Git、数据安全和协作流程。

## Not Completed / 未完成

1. `.gitignore`, `README.md`, and `LICENSE` are present. Git repository initialization, initial commit, and remote push remain pending because the sandbox currently blocks `.git` metadata creation.
2. Upstream source inspection and license verification remain pending because Codeberg DNS/network access was unavailable during this handoff.
3. Plugin implementation, build system, FFTW integration, GUI recreation, algorithm verification, tests, packaging, and signing have not started.

## Verification Evidence / 验证证据

- The working directory was empty before these documents were created.
- `git status` reported that the directory was not yet a Git repository.
- `git ls-remote https://codeberg.org/skullzy/DtBlkFx.git` failed with a DNS resolution error (`Could not resolve host: codeberg.org`).
- `git init -b main` was attempted; the sandbox denied `.git` metadata creation (`Operation not permitted`). An escalated retry was rejected by the automatic approval service with HTTP 503 before execution.
- `.gitignore` was reviewed and corrected so source `Makefile` files remain trackable; no credentials, personal paths, or private keys were found by repository scan.
- No upstream source files were copied or inferred as implementation.

## Next Agent Actions / 下一代理行动

1. Read `AGENTS.md`, `RULES.md`, and this file before acting.
2. Initialize Git, create a privacy-conscious `.gitignore`, inspect the staged diff, and make the initial commit.
3. Configure only the specified GitHub remote and push the intended branch after confirming credentials and remote state.
4. When network access is available, pin the upstream revision, inspect GPLv3 notices and build metadata, and record provenance before implementation.
5. Keep this document current after every material change, including commands and verification results.

## Handoff Contract / 交接约定

Each agent must leave the tree buildable or clearly state why it is not, avoid unrelated changes, preserve user changes, and report blockers with reproducible evidence. No agent may claim one-to-one GUI or algorithm fidelity before it has comparative evidence against the pinned upstream revision.

每个 agent 必须使工作树保持可复核状态，或明确说明不可复核原因；不得引入无关改动；必须保留用户改动并以可复现证据记录阻塞因素。未针对固定上游版本完成对比验证，不得宣称 GUI 或算法已一比一复刻。

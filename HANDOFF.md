# DTBLKFX for Macintosh — Handoff / Agent 交接

## Current Status / 当前状态

- **Date / 日期**: 2026-09-06
- **Phase / 阶段**: Build and dependency scaffolding / 编译与依赖脚手架
- **Branch / 分支**: `main`, tracking `origin/main`; initial commit `a83a3ca` / `main`，跟踪 `origin/main`；初始提交 `a83a3ca`
- **Implementation / 实现**: No plugin code; CMake scaffolding is available / 尚无插件代码；CMake 脚手架已建立
- **Upstream / 上游**: `https://codeberg.org/skullzy/DtBlkFx.git`
- **Remote target / 远程目标**: `https://github.com/Dirty-Octopus/dtblkfx4mackintosh.git`
- **License intent / 许可证意图**: Preserve and comply with GNU GPLv3 / 保留并遵循 GNU GPLv3

## Completed / 已完成

1. Added `AGENTS.md` with project overview, goals, mandatory reading, and current scope.
2. Added `RULES.md` with bilingual legal-style requirements covering fidelity, Apple Silicon, stability, GPLv3, Git, data safety, and collaboration.
3. Added this `HANDOFF.md` as the initial agent handoff record.

已新增 `AGENTS.md`、`RULES.md` 和本交接文档，内容覆盖项目概览、目标、复刻要求、Apple Silicon、稳定性、GPLv3、Git、数据安全和协作流程。

## Not Completed / 未完成

1. Git repository initialized on `main`; initial commit `a83a3ca` is pushed and tracks `origin/main`.
2. `.gitignore`, `README.md`, `LICENSE`, CMake presets, environment checks, dependency records, upstream fetch script, and project structure documents are present.
3. Upstream snapshot was fetched at `1506e444702d0da0f28fb3b813b88019e5a1dbc0`; libpng and zlib submodules are initialized at `78d28c6b9663d52465a3f6d15e21a995729ba410` and `abf180a067223611620dd97dd5681df7c7fa7c9b`.
4. Homebrew dependencies from `Brewfile` are installed: CMake 4.4.3, FFTW 3.3.11, and pkgconf 3.0.7.
5. Plugin implementation, FFTW linkage in a plugin target, GUI recreation, algorithm verification, tests, packaging, and signing have not started.

## Verification Evidence / 验证证据

- The working directory was empty before these documents were created.
- `git status --short --branch` reports `main...origin/main` before this change.
- `scripts/fetch-upstream.sh` and `git clone` completed successfully; `git -C .references/DtBlkFx rev-parse HEAD` reports `1506e444702d0da0f28fb3b813b88019e5a1dbc0`.
- `git -C .references/DtBlkFx submodule status` reports the pinned libpng and zlib revisions above.
- `./scripts/check-build-environment.sh` passes on `arm64` with Apple Clang, CMake, Make, `xcrun`, the macOS SDK, and pkg-config.
- `pkg-config --modversion fftw3` reports `3.3.11`; CMake FFTW discovery has been verified with the optional flag.
- `cmake --preset macos-arm64 -DDTBLKFX_ENABLE_FFTW=ON` and `cmake --build --preset macos-arm64` complete successfully; plugin targets remain disabled.
- Upstream license inspection confirms GPLv3 for DtBlkFx, the FFTW license files under `fftw/`, and permissive notice/license files for the initialized libpng and zlib submodules.
- `cmake --preset macos-arm64` and `cmake --build --preset macos-arm64` complete successfully with plugin targets disabled.
- `git check-ignore -v .references .references/DtBlkFx` confirms the reference path is ignored; repository scans found no credentials or personal paths.

## Next Agent Actions / 下一代理行动

1. Read `AGENTS.md`, `RULES.md`, and this file before acting.
2. Keep `scripts/fetch-upstream.sh` pinned to the verified upstream revision unless a new revision is explicitly reviewed and recorded.
3. Test `DTBLKFX_ENABLE_FFTW` explicitly, then inspect upstream single-precision FFTW linkage before writing plugin targets.
4. Add implementation under `src/`, tests under `tests/`, and evidence under `docs/`; update this file after each material change.

## Handoff Contract / 交接约定

Each agent must leave the tree buildable or clearly state why it is not, avoid unrelated changes, preserve user changes, and report blockers with reproducible evidence. No agent may claim one-to-one GUI or algorithm fidelity before it has comparative evidence against the pinned upstream revision.

每个 agent 必须使工作树保持可复核状态，或明确说明不可复核原因；不得引入无关改动；必须保留用户改动并以可复现证据记录阻塞因素。未针对固定上游版本完成对比验证，不得宣称 GUI 或算法已一比一复刻。

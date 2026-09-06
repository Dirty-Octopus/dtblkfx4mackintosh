# Upstream Reference / 上游参考

## Source / 来源

- Repository: <https://codeberg.org/skullzy/DtBlkFx.git>
- Local checkout directory: `.references/DtBlkFx` (ignored by Git)
- Fetch command: `scripts/fetch-upstream.sh`
- Pinned revision: `1506e444702d0da0f28fb3b813b88019e5a1dbc0`
- Snapshot date: 2025-12-13 (commit `Update readme for Codeberg`)

The checkout is intentionally kept outside the tracked tree so upstream files are not accidentally re-uploaded as part of the port. The script prints the checked-out revision for provenance recording.

上游副本故意放在受 Git 忽略的目录之外，防止上游文件被误作为移植内容重复上传。脚本会打印当前 revision，供来源记录使用。

## Current verification / 当前核验

The upstream repository was fetched successfully on 2026-09-06 at the pinned revision above. The checkout remains outside the tracked tree; no upstream source, asset, or license file has been copied into this repository.

2026-09-06 已成功拉取上游仓库并固定为上述 revision。上游副本仍在 Git 管理目录之外；本仓库未复制任何上游源码、资源或许可证文件。

The snapshot contains the upstream GPLv3 license, FFTW source and headers under `fftw/`, a placeholder note for the absent VST 2.x SDK under `vstsdk/`, VSTGUI sources under `vstgui/`, and a Visual Studio solution under `projects/`. The original build metadata targets Windows (`.sln`/`.vcxproj`), so a macOS build system must be designed from verified source facts rather than copied project files. See [`UPSTREAM_AUDIT.md`](UPSTREAM_AUDIT.md) for the source-level evidence and blockers.

该快照包含上游 GPLv3 许可证、`fftw/` 下的 FFTW 源码与头文件、`vstsdk/` 下仅有关于缺失 SDK 的占位说明、`vstgui/` 下的 VSTGUI 源码，以及 `projects/` 下的 Visual Studio 解决方案。原始构建元数据面向 Windows（`.sln`/`.vcxproj`），因此 macOS 构建系统必须依据已核验的源码事实重新设计，不得直接复制项目文件。源码证据与阻塞项见 [`UPSTREAM_AUDIT.md`](UPSTREAM_AUDIT.md)。

成功拉取后，必须先在此记录输出 revision 以及上游许可证和构建元数据，再新增实现文件。

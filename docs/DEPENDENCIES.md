# Dependencies / 依赖清单

This is a manifest of required or planned dependencies. Versions and license terms must be pinned from the upstream repository before implementation begins.

这是必需或计划依赖的清单。开始实现前，必须从上游仓库核定并固定版本及许可证条款。

| Dependency | Role | Current state | Verification required |
| --- | --- | --- | --- |
| Apple Clang + macOS SDK | Native arm64 compilation and system frameworks | Available on the current host | Record Xcode/SDK version in the build log |
| CMake | Cross-platform configuration | Installed via Homebrew, 4.4.3 | `cmake --version` |
| FFTW3f | Single-precision FFT/DSP implementation used by upstream (`fftwf_*`) | Homebrew FFTW 3.3.11 installed; upstream also contains FFTW sources under `.references/DtBlkFx/fftw`; port target remains disabled | Link `libfftw3f`, verify float ABI, planner flags, allocation/alignment, SIMD, and GPLv2 license before implementation |
| pkg-config | FFTW3f discovery | Homebrew pkgconf 3.0.7 installed | `pkg-config --modversion fftw3f` and `pkg-config --libs fftw3f` |
| VST 2.x SDK | Host-facing plugin ABI | **Unavailable/unverified**: `.references/DtBlkFx/vstsdk/README.md` is only a placement note; SDK sources are absent from the pinned checkout | Obtain SDK lawfully, record exact revision and redistribution terms, and verify macOS/arm64 host compatibility before use |
| VSTGUI | Upstream GUI runtime | Present in pinned checkout; legacy Carbon/Quartz and Mach-O code paths are present | Pin the exact upstream revision, inventory deprecated APIs, and validate bitmap layout and event behavior on arm64 |
| libpng + zlib | Upstream PNG resource loading | Upstream submodules initialized locally at libpng `78d28c6b9663d52465a3f6d15e21a995729ba410` and zlib `abf180a067223611620dd97dd5681df7c7fa7c9b`; not tracked here | Preserve libpng notice/license and zlib license when importing; keep revisions pinned |

No dependency is vendored or downloaded into the tracked tree by this phase. The `DTBLKFX_ENABLE_FFTW` CMake option validates only the single-precision `fftw3f` discovery path; the plugin target remains disabled until the FFTW variant, SDK terms, GUI compatibility, and macOS linkage are verified.

本阶段不在受 Git 管理的目录内捆绑或下载依赖。`DTBLKFX_ENABLE_FFTW` 只验证单精度 `fftw3f` 的发现路径；在核实 FFTW 变体、SDK 条款、GUI 兼容性和 macOS 链接前，插件目标保持关闭。

# Dependencies / 依赖清单

This is a manifest of required or planned dependencies. Versions and license terms must be pinned from the upstream repository before implementation begins.

这是必需或计划依赖的清单。开始实现前，必须从上游仓库核定并固定版本及许可证条款。

| Dependency | Role | Current state | Verification required |
| --- | --- | --- | --- |
| Apple Clang + macOS SDK | Native arm64 compilation and system frameworks | Available on the current host | Record Xcode/SDK version in the build log |
| CMake | Cross-platform configuration | Installed via Homebrew, 4.4.3 | `cmake --version` |
| FFTW3 | FFT/DSP implementation used by upstream | Homebrew 3.3.11 installed; upstream also contains FFTW sources under `.references/DtBlkFx/fftw`; port target remains disabled | Confirm float ABI, threading, SIMD, version, and license before linking implementation |
| pkg-config | FFTW3 discovery | Homebrew pkgconf 3.0.7 installed | `pkg-config --modversion fftw3` |
| VST 2.x SDK | Host-facing plugin ABI | Present in upstream snapshot under `.references/DtBlkFx/vstsdk` | Confirm redistribution terms and macOS Carbon/GUI compatibility before use |
| VSTGUI | Upstream GUI runtime | Present in upstream snapshot under `.references/DtBlkFx/vstgui` | Confirm exact revision and macOS support; preserve GUI behavior |
| libpng + zlib | Upstream PNG resource loading | Upstream submodules initialized locally at libpng `78d28c6b9663d52465a3f6d15e21a995729ba410` and zlib `abf180a067223611620dd97dd5681df7c7fa7c9b`; not tracked here | Preserve libpng notice/license and zlib license when importing; keep revisions pinned |

No dependency is vendored or downloaded into the tracked tree by this phase. The `DTBLKFX_ENABLE_FFTW` CMake option is used only for discovery validation; the plugin target remains disabled until the FFTW variant and macOS linkage are verified.

本阶段不在受 Git 管理的目录内捆绑或下载依赖。FFTW 变体核实前，CMake 选项 `DTBLKFX_ENABLE_FFTW` 保持关闭。

# Upstream Audit / 上游审计

## Audit identity / 审计标识

- Source: <https://codeberg.org/skullzy/DtBlkFx.git>
- Checkout: `.references/DtBlkFx` (ignored; never a tracked build input)
- Revision: `1506e444702d0da0f28fb3b813b88019e5a1dbc0`
- Submodules: libpng `78d28c6b9663d52465a3f6d15e21a995729ba410`; zlib `abf180a067223611620dd97dd5681df7c7fa7c9b`
- Audit date: 2026-09-06

This document records observed source facts. It is not a claim that the Apple Silicon port is implemented or behaviorally equivalent.

本文件只记录已核验的源码事实，不表示 Apple Silicon 移植已经实现或已经达到行为等价。

## Entry point and loading / 入口与加载

1. `dtblkfx/DtBlkFxMain.cpp:126-194` exports `VSTPluginMain`, checks the host VST version, initializes FFTW plans, loads PNG images, loads text presets, and constructs `DtBlkFx`.
2. `dtblkfx/DtBlkFxMain.cpp:30-40,151-156,197-223` contains Windows-only `HINSTANCE`, `DllMain`, `LoadLibraryA`, and `MessageBox` paths. The plugin directory is derived from `GetModuleFileName` and resource paths use the Windows separator in `BLKFX_DIR`.
3. The same file loads seven external resources: two slider backgrounds, two slider knobs, one splash bitmap, one global-control bitmap, and one effect-background bitmap. Presets are read from a sibling `presets.txt` file.
4. `dtblkfx/DTBlkFx.def:1-4` exports `VSTPluginMain` as the VST entry symbol. A macOS bundle must provide the equivalent exported symbol without copying the Windows `.def` mechanism.

## DSP and FFT / DSP 与 FFT

1. `dtblkfx/rfftw_float.h:25` defines `NUM_FFT_SZ = 34`, `MIN_FFT_SZ = 256`, and `MAX_FFT_SZ = 80640`. `rfftw_float.cpp:20-23` defines the exact size table from 256 through 80640.
2. `dtblkfx/rfftw_float.cpp:28-49` creates real-to-complex and complex-to-real one-dimensional plans with `FFTW_ESTIMATE`, using FFTW-aligned allocations. The implementation requires the single-precision `fftwf_*` ABI.
3. `dtblkfx/fftw_support.cpp:11-80` dynamically resolves `libfftw3f-3.dll` only on Windows; non-Windows builds use linked FFTW symbols through the same support interfaces. The macOS port must link `libfftw3f` and preserve symbol precision and allocation behavior.
4. `dtblkfx/DtBlkFx.cpp:1573-1676` implements the process loop: input circular buffering, parameter polling, FFT block scheduling, effect processing, inverse FFT, overlap/mix output, zero fill, and both additive `process` and replacing `processReplacing` paths.
5. `dtblkfx/FxRun1_0.cpp` contains the effect and mask chain. It includes filter, contrast, smear, threshold, clip, shift, constant shift, resize/repitch, harmonic filters and masks, automatic harmonic tracking, sweep/harmonic matching, plus stereo mixing effects. The port must preserve ordering and parameter-dependent dispatch rather than approximate it.

## Parameters and host contract / 参数与宿主契约

1. `dtblkfx/BlkFxParam.h:33-61` defines four global parameters, five parameters per effect set, eight effect sets, and `TOTAL_NUM = 44`. Channel count is compile-time selected as mono or stereo.
2. `dtblkfx/DtBlkFx.cpp:158-185` sets input/output channel counts, enables replacing processing and chunk programs, and assigns unique IDs `'h526'` for stereo and `'g319'` for mono.
3. `dtblkfx/DtBlkFx.cpp:309-398` serializes program and parameter state through VST chunks. State compatibility is part of parity and must be tested with captured upstream chunks.

## GUI and resources / GUI 与资源

1. `dtblkfx/Gui.cpp:127-153` derives the editor rectangle from resource dimensions and defines the six-stop spectrogram gradient. `Gui.cpp:163-207` splits the splash image into two spectrogram panels and adds stereo channel menus.
2. The pinned resource files have these dimensions: global control `410x26`; splash `410x191` split into two `410x95` panels; effect background `410x120` split into five `410x24` tiles; slider backgrounds `209x46`; slider knobs `23x46`. With eight effect rows, the derived editor height is `26 + 191 + 8*24 = 409` pixels.
3. `vstgui/vstgui.h`, `vstgui/vstplugscarbon.h`, `vstgui/vstplugsquartz.h`, `vstgui/vstplugsmacho.h`, and related sources contain legacy Carbon, Quartz, and Mach-O conditionals. These are evidence of an old GUI stack, not evidence of current arm64 compatibility.
4. `dtblkfx/Gui.cpp:42` contains a hard-coded Windows debug log path. Debug logging and all machine-specific paths must be removed or made explicit before release.

## Build blockers / 构建阻塞项

1. `projects/DTBlkFx.sln` and `projects/DTBlkFx.vcxproj` are Visual Studio projects with Win32/x64 configurations, Windows libraries, `.def` exports, and Windows resource assumptions; they are not a macOS build description.
2. `vstsdk/README.md` says to place VST SDK 2.4 in the directory, and the pinned checkout does not contain the SDK sources. The SDK must be obtained and its redistribution terms verified before compiling a VST target.
3. The upstream loader assumes external files beside the plugin and uses Windows path separators. macOS packaging must define a deterministic resource layout and preserve the original resource bytes and names where parity requires it.
4. No upstream macOS arm64 build, host validation, DSP regression suite, or GUI screenshot comparison is present in the pinned revision.

## License and provenance / 许可证与来源

- `LICENSE` is GNU GPLv3 for DtBlkFx.
- `fftw/COPYING` is GNU GPLv2 for the bundled FFTW source snapshot.
- `libpng/LICENSE` and `zlib/README` contain the respective permissive notices for the initialized submodules.
- The port must retain these notices, identify copied or modified files, and record the pinned source revision. No upstream file is copied into the tracked tree during this scaffolding phase.

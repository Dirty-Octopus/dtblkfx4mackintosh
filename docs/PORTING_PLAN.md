# Porting Plan / 移植计划

This plan is constrained by the pinned upstream audit in [`UPSTREAM_AUDIT.md`](UPSTREAM_AUDIT.md). The current phase stops before plugin implementation.

本计划受 [`UPSTREAM_AUDIT.md`](UPSTREAM_AUDIT.md) 的固定上游证据约束；当前阶段在插件实现前停止。

## 1. Source boundary / 来源边界

1. Treat `.references/DtBlkFx` at the recorded revision as the behavioral source of truth.
2. Copy only reviewed source, resources, and license notices into `src/`, `resources/`, or an explicitly documented third-party boundary. Never copy the checkout wholesale.
3. Record every copied or modified upstream file, its original path, revision, license, and reason in a provenance document before release.

## 2. Host format decision / 宿主格式决策

The first implementation target is VST 2.x on macOS because the upstream entry point, parameter ABI, chunk format, unique IDs, and editor contract are VST 2.x. VST 3, AU, and CLAP wrappers are out of scope until VST 2.x parity is measured. The missing SDK is a release blocker; no SDK source may be guessed, scraped, or committed without lawful provenance and redistribution review.

首个实现目标为 macOS VST 2.x，因为上游入口、参数 ABI、chunk 格式、唯一 ID 和编辑器契约均为 VST 2.x。VST 3、AU 和 CLAP 封装须待 VST 2.x 完成可测量复刻后再评估。SDK 缺失是发布阻塞项；不得猜测、抓取或在未完成合法来源与再分发审查前提交 SDK 源码。

## 3. Apple Silicon build / Apple Silicon 构建

1. Keep `CMAKE_OSX_ARCHITECTURES=arm64` as the minimum release architecture. Universal 2 is optional only after arm64 tests pass.
2. Replace Visual Studio project files with CMake targets that explicitly list sources, system frameworks, include paths, exported symbols, bundle resources, and install layout.
3. Keep plugin, standalone diagnostics, and test targets separate so host-facing packaging cannot hide failed DSP tests.

## 4. FFTW and DSP parity / FFTW 与 DSP 复刻

1. Link single-precision `libfftw3f`; do not substitute `libfftw3` or silently change the `float` ABI.
2. Preserve the 34 FFT sizes, `FFTW_ESTIMATE`, real/complex transform direction, aligned allocation, normalization, circular-buffer scheduling, overlap rules, and parameter interpolation from the upstream sources.
3. First build a reference harness around the pinned implementation and a port harness using identical float input, sample rate, block size, parameters, and reset sequence. Compare output buffers, FFT state, latency, and serialized chunks with explicit tolerances.
4. Test impulse, silence, sine, harmonic, noise, mono, stereo, bypass, delay, overlap, parameter automation, preset recall, and host block-size changes. A perceptual listening check is supplementary and cannot replace numeric comparisons.

## 5. GUI parity / GUI 复刻

1. Preserve the original bitmap bytes, dimensions, tile slicing, 409-pixel derived editor height, six-stop spectrogram gradient, control order, labels, menus, mouse behavior, and keyboard behavior.
2. Isolate the old VSTGUI Carbon/Quartz adapter from the visual model. If deprecated APIs prevent arm64 operation, replace only the platform window/event layer while keeping the measured drawing and interaction model unchanged.
3. Capture reference screenshots at deterministic parameter states and compare pixel diffs at the same scale. Test both mono and stereo layouts, all eight effect rows, menus, hover/drag states, preset state, and error states.
4. Record every unavoidable platform difference. Do not call the GUI one-to-one until the comparison suite passes and the remaining differences are explicitly accepted.

## 6. Resources and packaging / 资源与打包

Package resources inside the macOS plugin bundle with a stable lookup rooted at the bundle location. Keep the original resource filenames and bytes unless an audit documents why a conversion is required. Validate that missing resources fail deterministically and do not crash the host.

## 7. License and release gates / 许可证与发布门槛

Before release, verify GPLv3 obligations for DtBlkFx, GPLv2 terms for the bundled FFTW snapshot if used, and the libpng/zlib notices. Record VST SDK terms separately. Release is blocked by missing notices, unverified SDK rights, failed arm64 builds, numeric DSP drift, GUI diff failures, host crashes, or undisclosed machine-specific paths.

## 8. Planned tracked layout / 计划中的受管目录

```text
src/plugin/       VST entry point and host adapter
src/dsp/          FFT buffers, effect chain, parameter/state logic
src/gui/          Visual model and platform-neutral controls
src/platform/mac/ macOS bundle/window/resource adapter
resources/        Audited upstream PNG and preset assets
tests/dsp/        Numeric reference and regression tests
tests/gui/        Deterministic screenshot and interaction checks
tests/host/       Load, lifecycle, chunk, and channel-contract checks
docs/             Audit, provenance, decisions, and test evidence
```

The directories above are planned ownership boundaries only; empty directories are not implementation.

# Build Environment / 编译环境

## Supported baseline / 支持基线

The supported release build is macOS on Apple Silicon (`arm64`). The repository uses Apple Clang and CMake; the initial scaffolding has no plugin target yet.

发布构建目标为 Apple Silicon（`arm64`）macOS。仓库使用 Apple Clang 与 CMake；当前脚手架尚未包含插件目标。

Required tools:

- Xcode Command Line Tools or Xcode, including the macOS SDK and `xcrun`.
- Apple Clang (`clang`).
- CMake 3.24 or newer.
- Make, or another generator supported by CMake.
- FFTW3 single-precision (`fftw3f`) and `pkg-config` when enabling the verified FFTW configuration.

Run `scripts/check-build-environment.sh` before configuring. It reports missing tools and the active SDK. `pkg-config` is optional while FFTW3f integration is disabled.

## Configure and build scaffolding / 配置与构建脚手架

```sh
./scripts/check-build-environment.sh
cmake --preset macos-arm64
cmake --build --preset macos-arm64
```

The preset forces `CMAKE_OSX_ARCHITECTURES=arm64` and leaves plugin compilation disabled until upstream sources and build requirements are verified. Enabling `DTBLKFX_ENABLE_FFTW` before recording the upstream FFTW variant is not permitted.

预设强制 `CMAKE_OSX_ARCHITECTURES=arm64`，并在核实上游源码与构建要求前关闭插件编译。在记录上游 FFTW 变体前不得启用 `DTBLKFX_ENABLE_FFTW`。

After installing the declared Homebrew dependencies, validate the optional FFTW discovery without enabling plugin compilation:

```sh
cmake --preset macos-arm64 -DDTBLKFX_ENABLE_FFTW=ON
cmake --build --preset macos-arm64
```

The current upstream uses single-precision FFTW (`fftwf_*` symbols). The discovery check must resolve the `fftw3f` package and `libfftw3f`; resolving only the double-precision `fftw3` package is insufficient. This check does not claim that the plugin port is complete.

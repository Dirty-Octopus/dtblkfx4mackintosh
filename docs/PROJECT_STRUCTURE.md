# Project Structure / 项目文件结构

The layout separates tracked project metadata, build scaffolding, source code, tests, and the untracked upstream reference. New files must follow these ownership boundaries.

目录将受 Git 管理的项目资料、编译脚手架、源代码、测试和不受 Git 管理的上游参考分开。新增文件必须遵守以下边界。

```text
.
├── .gitignore                 # Repository-wide private/build exclusions
├── AGENTS.md                  # Agent orientation and project goals
├── RULES.md                   # Binding bilingual engineering rules
├── HANDOFF.md                 # Current agent coordination state
├── LICENSE                    # Project license notice
├── README.md                  # Public project entry point
├── CMakeLists.txt             # Top-level configuration and dependency gates
├── CMakePresets.json          # Reproducible macOS arm64 configure/build presets
├── cmake/                     # Shared CMake modules (add only when needed)
├── docs/                      # Build, dependency, provenance, and design records
├── scripts/                   # Reproducible maintenance and environment commands
├── src/                       # Ported plugin implementation (future phase)
│   ├── plugin/                # VST entry point and host adapter
│   ├── dsp/                   # FFT, effects, parameters, and state
│   ├── gui/                   # Platform-neutral visual model and controls
│   └── platform/mac/          # macOS bundle, window, and resource adapter
├── tests/                     # DSP/UI/host regression tests (future phase)
│   ├── dsp/                   # Numeric reference and regression tests
│   ├── gui/                   # Screenshot and interaction checks
│   └── host/                  # Lifecycle, chunk, and channel-contract checks
├── resources/                 # Verified plugin resources (future phase)
└── .references/               # Local upstream checkout; always ignored by Git
```

Rules:

1. Keep generated output under `build/`, `dist/`, or `artifacts/`; these paths are ignored.
2. Keep the upstream checkout only at `.references/DtBlkFx`; never copy it wholesale into `src/`.
3. Put implementation in `src/`, tests in `tests/`, and evidence or decisions in `docs/`.
4. Record every new external dependency and its license in `docs/DEPENDENCIES.md`.
5. Use the planned `src/` and `tests/` subdirectories defined above; do not create parallel ownership roots.

规则：

1. 生成物必须放在 `build/`、`dist/` 或 `artifacts/`；这些路径已被忽略。
2. 上游副本只能放在 `.references/DtBlkFx`；不得整体复制到 `src/`。
3. 实现放在 `src/`，测试放在 `tests/`，证据和决策放在 `docs/`。
4. 每个新增外部依赖及其许可证必须记录在 `docs/DEPENDENCIES.md`。
5. 使用上列规划的 `src/` 与 `tests/` 子目录；不得创建平行的职责根目录。

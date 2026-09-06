# DtBlkFx for Macintosh

This repository is the Apple Silicon macOS port of [DtBlkFx](https://codeberg.org/skullzy/DtBlkFx), an audio plugin built around FFTW-based processing.

The port targets functional and visual parity with the upstream plugin, including its graphical interface, DSP algorithms, parameter behavior, and host integration. GNU General Public License v3.0 (GPLv3) requirements apply to the project and to any distributed derivative work.

## Repository status

The repository is initialized for development and project coordination. This phase provides the ignored upstream-reference workflow, dependency manifest, arm64 CMake scaffolding, environment check, and project layout. The plugin implementation has not yet been ported.

## Quick start

```sh
./scripts/check-build-environment.sh
cmake --preset macos-arm64
cmake --build --preset macos-arm64
```

To fetch the upstream reference after network access is available:

```sh
./scripts/fetch-upstream.sh
```

The checkout is created at `.references/DtBlkFx`, which is ignored and is never included in commits. See [`docs/BUILD_ENVIRONMENT.md`](docs/BUILD_ENVIRONMENT.md), [`docs/DEPENDENCIES.md`](docs/DEPENDENCIES.md), and [`docs/PROJECT_STRUCTURE.md`](docs/PROJECT_STRUCTURE.md) for the binding workflow.

## Upstream

- Source project: <https://codeberg.org/skullzy/DtBlkFx.git>
- Port repository: <https://github.com/Dirty-Octopus/dtblkfx4mackintosh.git>

## Project documents

- [`AGENTS.md`](AGENTS.md): required orientation for agents, project overview, and objectives.
- [`RULES.md`](RULES.md): binding bilingual engineering rules.
- [`HANDOFF.md`](HANDOFF.md): current coordination state between agents.

## License

See [`LICENSE`](LICENSE). Upstream copyright and license notices must be preserved when upstream code or assets are incorporated.

# Contributing

Thanks for considering a contribution to `dev-workstation`. This project
bootstraps a real development machine, so correctness and consistency matter
more than cleverness — please read this before opening a PR.

## Requirements to test locally

You need an actual WSL2 Ubuntu environment. Static review isn't enough:
run `./bootstrap.sh` (or `task bootstrap`) and confirm it works, both on a
fresh distro and re-run on an already-configured one (this project must stay
idempotent).

CI (`.github/workflows/bootstrap.yml`) runs `bootstrap.sh` twice on a plain
`ubuntu-latest` runner to catch regressions in the non-WSL-specific
installers and prove idempotency automatically. It cannot cover the
WSL/Windows-only paths (fonts and Windows Terminal on the Windows side,
Docker Desktop integration) — those still need a real WSL run before
merging.

## Architecture

Every tool lives in its own installer under `installers/<name>.sh` and
implements the same contract:

```bash
dw::installer::<name>::installed()   # returns 0 if the tool is already present
dw::installer::<name>::install()     # installs it, only called if installed() is false
dw::installer::<name>::configure()   # optional: idempotent configuration, always called
```

`dw::installer::run <name>` (in `installers/common.sh`) drives that contract.
Registering a new installer means:

1. Add `installers/<name>.sh` (and `config/<name>.conf` if it needs
   configuration values).
2. Source both from `lib/common.sh`, in the same relative order as the other
   config/installer entries.
3. Add `dw::installer::run <name>` to `tasks/install.sh`.

Conventions to follow throughout:

- `dw::` namespace everywhere, no bare function names.
- Short, single-responsibility functions.
- `set -Eeuo pipefail`, quoted variables.
- Every source file (`.sh` and `.ps1`) carries the copyright/SPDX header
  (`# Copyright (C) <year> <name>` / `# SPDX-License-Identifier: GPL-3.0-or-later`)
  right after the shebang.
- No duplicated logic — if two installers need the same thing (e.g. resolving
  a GitHub release), put it in `lib/`.
- No placeholders, TODOs, or half-finished code.

The installer contract itself is considered frozen: if a feature genuinely
doesn't fit it, open an issue to discuss before implementing a workaround.

## Commit style

One focused change per commit/PR, using
[Conventional Commits](https://www.conventionalcommits.org/) (`feat(scope):`,
`fix(scope):`, `refactor(scope):`, ...). Don't bundle unrelated changes.

## Lint and format

```bash
task lint     # shellcheck across every *.sh file
task format   # shfmt -w across every *.sh file
```

Both must pass before opening a PR — CI runs the same checks
(`.github/workflows/lint.yml`).

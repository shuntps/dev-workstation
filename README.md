# dev-workstation

[![Lint](https://github.com/shuntps/dev-workstation/actions/workflows/lint.yml/badge.svg)](https://github.com/shuntps/dev-workstation/actions/workflows/lint.yml)
[![Bootstrap](https://github.com/shuntps/dev-workstation/actions/workflows/bootstrap.yml/badge.svg)](https://github.com/shuntps/dev-workstation/actions/workflows/bootstrap.yml)
[![Release](https://github.com/shuntps/dev-workstation/actions/workflows/release.yml/badge.svg)](https://github.com/shuntps/dev-workstation/actions/workflows/release.yml)
[![Version](https://img.shields.io/github/v/release/shuntps/dev-workstation)](https://github.com/shuntps/dev-workstation/releases/latest)
[![License: GPL v3](https://img.shields.io/badge/license-GPLv3-blue.svg)](LICENSE)

Automated and reproducible Ubuntu/WSL development workstation bootstrap.

`dev-workstation` sets up a fresh WSL2 Ubuntu guest for web development in one
command. It's idempotent — run it as many times as you want on the same
machine, and it only installs or changes what's missing.

## What it sets up

- **System** — apt update/upgrade/autoremove/autoclean, base packages (`curl`,
  `wget`, `jq`, `tree`, `htop`, ...)
- **Git** — sane global defaults (rebase on pull, prune on fetch, autoSetupRemote,
  rerere, ...) and a global `.gitignore`
- **SSH** — `openssh-client` and an SSH key generated if none exists
- **GitHub CLI (`gh`)** — installed via the official apt repository
- **Node.js** — managed by [fnm](https://github.com/Schniz/fnm), always tracking
  the latest LTS release
- **pnpm** — enabled via Node's built-in [corepack](https://nodejs.org/api/corepack.html)
- **Bun** — installed via its official install script
- **Python** — base interpreter and tooling via apt
- **Docker** — verifies Docker Desktop's WSL integration is reachable from WSL
  (this project does not install a Docker Engine inside WSL)
- **Fonts** — JetBrainsMono Nerd Font, installed for both WSL and Windows
  (registered with Windows Terminal automatically)
- **Windows Terminal** — Tokyo Night color scheme applied to all profiles
- **Starship** — a prompt showing OS, user@host, directory, git status, language
  versions, command duration, and time
- **lazygit** and **direnv**

## Requirements

- Windows 11 with WSL2
- An Ubuntu distribution installed under WSL
- Docker Desktop with WSL integration enabled, if you want the Docker step to
  pass

## Usage

```bash
git clone https://github.com/shuntps/dev-workstation.git
cd dev-workstation
./bootstrap.sh
```

Or, using [Task](https://taskfile.dev) or `make`:

```bash
task bootstrap
# or
make bootstrap
```

Re-run the same command any time to pick up updates (e.g. the latest Node.js
LTS) — already-installed tools are detected and skipped.

## Keeping WSL and PowerShell up to date

`bootstrap.sh` keeps the Ubuntu guest up to date, but the Windows host side —
the WSL platform itself and PowerShell — is updated separately, from a
Windows terminal (PowerShell or cmd, not inside Ubuntu).

**WSL** (platform and kernel):

```powershell
wsl --update
wsl --shutdown
```

`wsl --update` fetches the latest WSL platform/kernel; `wsl --shutdown`
restarts the WSL VM so the update takes effect. Check what's currently
installed with `wsl --version`.

**PowerShell 7+** (`pwsh`), if installed via winget:

```powershell
winget upgrade Microsoft.PowerShell
```

Windows PowerShell 5.1 (the version built into Windows) is updated through
Windows Update, not winget.

## Resetting and reinstalling the WSL Ubuntu guest

If the Ubuntu guest gets into a broken state, you can wipe it and start over.
Run these from a Windows terminal (PowerShell or cmd, not inside Ubuntu).

List installed distributions to get the exact name (e.g. `Ubuntu`,
`Ubuntu-22.04`):

```powershell
wsl -l -v
```

Unregister it — **this permanently deletes the guest's filesystem**,
including anything not pushed to a remote:

```powershell
wsl --unregister <DistroName>
```

Reinstall a fresh Ubuntu guest:

```powershell
wsl --install -d Ubuntu
```

(or reinstall the "Ubuntu" app from the Microsoft Store). Open it once to
finish setup and create your Linux user, then bootstrap it again:

```bash
git clone https://github.com/shuntps/dev-workstation.git
cd dev-workstation
./bootstrap.sh
```

## Project structure

```
bootstrap.sh      # entry point
lib/              # shared bash helpers (logger, apt, filesystem, shell, os, ...)
tasks/            # top-level tasks (system, packages, install)
installers/       # one file per tool, exposing installed()/install()/configure()
config/           # per-tool configuration (versions, package lists, ...)
```

Each installer follows the same contract:

```bash
dw::installer::<name>::installed()   # returns whether the tool is present
dw::installer::<name>::install()     # installs it if missing
dw::installer::<name>::configure()   # optional: idempotent configuration step
```

## Development

```bash
task lint     # shellcheck across all scripts
task format   # shfmt -w across all scripts
```

## Contributing

Contributions are welcome — see [CONTRIBUTING.md](CONTRIBUTING.md) for the
installer architecture, coding conventions, and how to test changes on WSL
before opening a PR.

## License

GPL-3.0 — see [LICENSE](LICENSE).

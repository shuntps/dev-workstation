#!/usr/bin/env bash

# Copyright (C) 2026 Shunt
# SPDX-License-Identifier: GPL-3.0-or-later

# ==============================================================================
# Dev Workstation
# Common Library Loader
# ==============================================================================

set -Eeuo pipefail

DW_ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
readonly DW_ROOT_DIR

# Core libraries
source "${DW_ROOT_DIR}/lib/logger.sh"
source "${DW_ROOT_DIR}/lib/command.sh"
source "${DW_ROOT_DIR}/lib/filesystem.sh"
source "${DW_ROOT_DIR}/lib/user.sh"
source "${DW_ROOT_DIR}/lib/os.sh"
source "${DW_ROOT_DIR}/lib/apt.sh"
source "${DW_ROOT_DIR}/lib/shell.sh"
source "${DW_ROOT_DIR}/lib/github.sh"

# Task libraries
source "${DW_ROOT_DIR}/tasks/install.sh"

# Configuration
source "${DW_ROOT_DIR}/config/workstation.conf"
source "${DW_ROOT_DIR}/config/git.conf"
source "${DW_ROOT_DIR}/config/packages.conf"
source "${DW_ROOT_DIR}/config/ssh.conf"
source "${DW_ROOT_DIR}/config/gh.conf"
source "${DW_ROOT_DIR}/config/node.conf"
source "${DW_ROOT_DIR}/config/bun.conf"
source "${DW_ROOT_DIR}/config/python.conf"
source "${DW_ROOT_DIR}/config/fonts.conf"
source "${DW_ROOT_DIR}/config/terminal.conf"

# Installer Framework
source "${DW_ROOT_DIR}/installers/common.sh"

# Installers
source "${DW_ROOT_DIR}/installers/git.sh"
source "${DW_ROOT_DIR}/installers/ssh.sh"
source "${DW_ROOT_DIR}/installers/gh.sh"
source "${DW_ROOT_DIR}/installers/github.sh"
source "${DW_ROOT_DIR}/installers/node.sh"
source "${DW_ROOT_DIR}/installers/pnpm.sh"
source "${DW_ROOT_DIR}/installers/bun.sh"
source "${DW_ROOT_DIR}/installers/python.sh"
source "${DW_ROOT_DIR}/installers/docker.sh"
source "${DW_ROOT_DIR}/installers/fonts.sh"
source "${DW_ROOT_DIR}/installers/terminal.sh"
source "${DW_ROOT_DIR}/installers/starship.sh"
source "${DW_ROOT_DIR}/installers/lazygit.sh"
source "${DW_ROOT_DIR}/installers/direnv.sh"

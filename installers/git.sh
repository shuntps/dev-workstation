#!/usr/bin/env bash

# Copyright (C) 2026 Shunt
# SPDX-License-Identifier: GPL-3.0-or-later

# ==============================================================================
# Git Installer
# ==============================================================================

dw::installer::git::installed() {

  dw::command::exists git

}

dw::installer::git::install() {

  dw::apt::install git

}

dw::installer::git::configure() {

  git config --global init.defaultBranch "${GIT_DEFAULT_BRANCH}"

  git config --global pull.rebase "${GIT_PULL_REBASE}"

  git config --global fetch.prune "${GIT_FETCH_PRUNE}"

  git config --global core.editor "${GIT_EDITOR}"

  git config --global color.ui "${GIT_COLOR_UI}"

  git config --global push.autoSetupRemote "${GIT_AUTO_SETUP_REMOTE}"

  git config --global rerere.enabled "${GIT_RERERE_ENABLED}"

  git config --global core.autocrlf "${GIT_AUTOCRLF}"

  git config --global core.excludesFile "${GIT_GLOBAL_GITIGNORE}"

  dw::installer::git::configure_global_gitignore

}

dw::installer::git::configure_global_gitignore() {

  dw::fs::mkdir "$(dirname "${GIT_GLOBAL_GITIGNORE}")"

  if dw::fs::file_exists "${GIT_GLOBAL_GITIGNORE}"; then

    return

  fi

  cat >"${GIT_GLOBAL_GITIGNORE}" <<'EOF'
# OS
.DS_Store
Thumbs.db
Desktop.ini

# Editor
.vscode/
.idea/
*.swp

# Environment
.env
.env.local

# Dependencies
node_modules/

# Logs
*.log
EOF

}

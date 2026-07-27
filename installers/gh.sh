#!/usr/bin/env bash

# Copyright (C) 2026 Shunt
# SPDX-License-Identifier: GPL-3.0-or-later

# ==============================================================================
# GitHub CLI Installer
# ==============================================================================

readonly DW_GH_KEYRING="/etc/apt/keyrings/githubcli-archive-keyring.gpg"
readonly DW_GH_SOURCE_LIST="/etc/apt/sources.list.d/github-cli.list"

dw::installer::gh::installed() {

  dw::command::exists gh

}

dw::installer::gh::install() {

  dw::installer::gh::add_repository

  dw::apt::install gh

}

dw::installer::gh::configure() {

  gh config set git_protocol "${GH_GIT_PROTOCOL}"

}

dw::installer::gh::add_repository() {

  if dw::fs::file_exists "${DW_GH_SOURCE_LIST}"; then

    return

  fi

  dw::logger::info "Adding GitHub CLI apt repository..."

  sudo mkdir -p -m 755 /etc/apt/keyrings

  curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg |
    sudo tee "${DW_GH_KEYRING}" >/dev/null

  sudo chmod go+r "${DW_GH_KEYRING}"

  echo "deb [arch=$(dpkg --print-architecture) signed-by=${DW_GH_KEYRING}] https://cli.github.com/packages stable main" |
    sudo tee "${DW_GH_SOURCE_LIST}" >/dev/null

  dw::apt::update

  dw::logger::success "GitHub CLI apt repository added."

}

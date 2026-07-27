#!/usr/bin/env bash

# Copyright (C) 2026 Shunt
# SPDX-License-Identifier: GPL-3.0-or-later

# ==============================================================================
# Lazygit Installer
# ==============================================================================

dw::installer::lazygit::installed() {

  dw::command::exists lazygit

}

dw::installer::lazygit::install() {

  local version
  local tmp_dir
  local archive

  version="$(dw::github::latest_tag "jesseduffield/lazygit")"
  tmp_dir="$(mktemp -d)"
  archive="${tmp_dir}/lazygit.tar.gz"

  curl -fsSL -o "${archive}" \
    "https://github.com/jesseduffield/lazygit/releases/download/v${version}/lazygit_${version}_Linux_x86_64.tar.gz"

  tar -xzf "${archive}" -C "${tmp_dir}" lazygit

  sudo install "${tmp_dir}/lazygit" /usr/local/bin/lazygit

  rm -rf "${tmp_dir}"

}

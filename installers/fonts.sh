#!/usr/bin/env bash

# Copyright (C) 2026 Shunt
# SPDX-License-Identifier: GPL-3.0-or-later

# ==============================================================================
# Nerd Font Installer (JetBrainsMono Nerd Font)
# ==============================================================================

readonly DW_FONT_DIR="${HOME}/.local/share/fonts/JetBrainsMonoNerdFont"
# DW_ROOT_DIR is assigned by lib/common.sh before this file is sourced.
# shellcheck disable=SC2153
readonly DW_FONT_SCRIPT="${DW_ROOT_DIR}/installers/fonts.ps1"

dw::installer::fonts::installed() {

  dw::fs::directory_exists "${DW_FONT_DIR}"

}

dw::installer::fonts::install() {

  local version

  version="$(dw::github::latest_tag "ryanoasis/nerd-fonts")"

  dw::installer::fonts::install_wsl "${version}"

  if dw::os::is_wsl; then

    dw::installer::fonts::install_windows "${version}"

  fi

}

dw::installer::fonts::install_wsl() {

  local version="$1"
  local tmp_dir
  local archive

  dw::apt::install fontconfig

  tmp_dir="$(mktemp -d)"
  archive="${tmp_dir}/font.zip"

  curl -fsSL -o "${archive}" \
    "$(dw::installer::fonts::download_url "${version}")"

  dw::fs::mkdir "${DW_FONT_DIR}"

  unzip -oq "${archive}" "*.ttf" -d "${DW_FONT_DIR}"

  rm -rf "${tmp_dir}"

  fc-cache -f "${DW_FONT_DIR}" >/dev/null

}

dw::installer::fonts::install_windows() {

  local version="$1"

  if ! dw::command::exists powershell.exe; then

    dw::logger::warning "powershell.exe not found; skipping Windows-side font install."

    return

  fi

  dw::logger::info "Installing ${FONT_NAME} on Windows and configuring Windows Terminal..."

  if ! powershell.exe -NoProfile -ExecutionPolicy Bypass \
    -File "$(wslpath -w "${DW_FONT_SCRIPT}")" \
    -FontName "${FONT_NAME}" \
    -FontUrl "$(dw::installer::fonts::download_url "${version}")"; then

    dw::logger::warning "Windows-side font/Windows Terminal configuration failed."

  fi

}

dw::installer::fonts::download_url() {

  local version="$1"

  printf "https://github.com/ryanoasis/nerd-fonts/releases/download/v%s/%s.zip\n" \
    "${version}" "${FONT_ARCHIVE_NAME}"

}

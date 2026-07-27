#!/usr/bin/env bash

# Copyright (C) 2026 Shunt
# SPDX-License-Identifier: GPL-3.0-or-later

# ==============================================================================
# Windows Terminal Installer (WSL color scheme)
# ==============================================================================

readonly DW_TERMINAL_STATE_FILE="${HOME}/.local/share/dev-workstation/terminal-color-scheme"
readonly DW_TERMINAL_SCRIPT="${DW_ROOT_DIR}/installers/terminal.ps1"

dw::installer::terminal::installed() {

  dw::fs::file_exists "${DW_TERMINAL_STATE_FILE}" &&
    [[ "$(cat "${DW_TERMINAL_STATE_FILE}")" == "${TERMINAL_COLOR_SCHEME}" ]]

}

dw::installer::terminal::install() {

  if ! dw::os::is_wsl || ! dw::command::exists powershell.exe; then

    dw::logger::warning "Not running under WSL with Windows Terminal; skipping color scheme."

    return

  fi

  dw::logger::info "Applying ${TERMINAL_COLOR_SCHEME} color scheme to Windows Terminal..."

  if ! powershell.exe -NoProfile -ExecutionPolicy Bypass \
    -File "$(wslpath -w "${DW_TERMINAL_SCRIPT}")" \
    -SchemeName "${TERMINAL_COLOR_SCHEME}"; then

    dw::logger::warning "Windows Terminal color scheme configuration failed."

    return

  fi

  dw::fs::mkdir "$(dirname "${DW_TERMINAL_STATE_FILE}")"

  printf "%s\n" "${TERMINAL_COLOR_SCHEME}" >"${DW_TERMINAL_STATE_FILE}"

}

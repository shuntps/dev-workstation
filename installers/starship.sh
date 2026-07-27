#!/usr/bin/env bash

# Copyright (C) 2026 Shunt
# SPDX-License-Identifier: GPL-3.0-or-later

# ==============================================================================
# Starship Installer
# ==============================================================================

readonly DW_STARSHIP_RC_MARKER="# dev-workstation: starship"
readonly DW_STARSHIP_CONFIG="${HOME}/.config/starship.toml"

dw::installer::starship::installed() {

  dw::command::exists starship

}

dw::installer::starship::install() {

  curl -sS https://starship.rs/install.sh | sh -s -- -y

}

dw::installer::starship::configure() {

  dw::shell::configure_rc "${DW_STARSHIP_RC_MARKER}" \
    'eval "$(starship init bash)"'

  dw::installer::starship::configure_prompt

}

dw::installer::starship::configure_prompt() {

  dw::fs::mkdir "$(dirname "${DW_STARSHIP_CONFIG}")"

  if dw::fs::file_exists "${DW_STARSHIP_CONFIG}"; then

    return

  fi

  cp "${DW_ROOT_DIR}/installers/starship.toml" "${DW_STARSHIP_CONFIG}"

}

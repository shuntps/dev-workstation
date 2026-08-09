#!/usr/bin/env bash

# Copyright (C) 2026 Shunt
# SPDX-License-Identifier: MIT

# ==============================================================================
# Bun Installer
# ==============================================================================

readonly DW_BUN_BIN="${BUN_INSTALL}/bin/bun"
readonly DW_BUN_RC_MARKER="# dev-workstation: bun"

dw::installer::bun::installed() {

  dw::fs::file_exists "${DW_BUN_BIN}"

}

dw::installer::bun::install() {

  curl -fsSL https://bun.sh/install | bash

}

dw::installer::bun::configure() {

  dw::installer::bun::configure_shell

}

dw::installer::bun::configure_shell() {

  dw::shell::configure_rc "${DW_BUN_RC_MARKER}" \
    "export BUN_INSTALL=\"${BUN_INSTALL}\"" \
    "export PATH=\"${BUN_INSTALL}/bin:\$PATH\""

}

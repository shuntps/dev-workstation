#!/usr/bin/env bash

# Copyright (C) 2026 Shunt
# SPDX-License-Identifier: GPL-3.0-or-later

# ==============================================================================
# Node.js Installer (fnm)
# ==============================================================================

readonly DW_FNM_BIN="${FNM_DIR}/fnm"
readonly DW_FNM_RC_MARKER="# dev-workstation: fnm"

dw::installer::node::installed() {

  dw::fs::file_exists "${DW_FNM_BIN}"

}

dw::installer::node::install() {

  curl -fsSL https://fnm.vercel.app/install |
    bash -s -- --install-dir "${FNM_DIR}" --skip-shell

}

dw::installer::node::configure() {

  dw::installer::node::configure_shell

  eval "$("${DW_FNM_BIN}" env --shell bash)"

  "${DW_FNM_BIN}" install --lts

  "${DW_FNM_BIN}" default lts-latest

  "${DW_FNM_BIN}" use lts-latest

}

dw::installer::node::configure_shell() {

  dw::shell::configure_rc "${DW_FNM_RC_MARKER}" \
    "export PATH=\"${FNM_DIR}:\$PATH\"" \
    'eval "$(fnm env --shell bash)"'

}

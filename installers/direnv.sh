#!/usr/bin/env bash

# Copyright (C) 2026 Shunt
# SPDX-License-Identifier: GPL-3.0-or-later

# ==============================================================================
# direnv Installer
# ==============================================================================

readonly DW_DIRENV_RC_MARKER="# dev-workstation: direnv"

dw::installer::direnv::installed() {

  dw::command::exists direnv

}

dw::installer::direnv::install() {

  dw::apt::install direnv

}

dw::installer::direnv::configure() {

  dw::shell::configure_rc "${DW_DIRENV_RC_MARKER}" \
    'eval "$(direnv hook bash)"'

}

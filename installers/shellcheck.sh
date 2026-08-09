#!/usr/bin/env bash

# Copyright (C) 2026 Shunt
# SPDX-License-Identifier: GPL-3.0-or-later

# ==============================================================================
# ShellCheck Installer
# ==============================================================================

dw::installer::shellcheck::installed() {

  dw::command::exists shellcheck

}

dw::installer::shellcheck::install() {

  dw::apt::install shellcheck

}

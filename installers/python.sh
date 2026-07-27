#!/usr/bin/env bash

# Copyright (C) 2026 Shunt
# SPDX-License-Identifier: GPL-3.0-or-later

# ==============================================================================
# Python Installer (apt)
# ==============================================================================

dw::installer::python::installed() {

  dw::command::exists python3

}

dw::installer::python::install() {

  dw::apt::install "${PYTHON_PACKAGES[@]}"

}

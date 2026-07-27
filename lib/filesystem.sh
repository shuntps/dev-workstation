#!/usr/bin/env bash

# Copyright (C) 2026 Shunt
# SPDX-License-Identifier: GPL-3.0-or-later

# ==============================================================================
# Filesystem Helpers
# ==============================================================================

dw::fs::directory_exists() {
  [[ -d "$1" ]]
}

dw::fs::file_exists() {
  [[ -f "$1" ]]
}

dw::fs::mkdir() {
  mkdir -p "$1"
}

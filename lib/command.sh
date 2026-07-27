#!/usr/bin/env bash

# Copyright (C) 2026 Shunt
# SPDX-License-Identifier: GPL-3.0-or-later

# ==============================================================================
# Command Helpers
# ==============================================================================

dw::command::exists() {
  command -v "$1" >/dev/null 2>&1
}

dw::command::require() {

  local command="$1"

  if ! dw::command::exists "${command}"; then
    dw::logger::fatal "Required command not found: ${command}"
  fi
}

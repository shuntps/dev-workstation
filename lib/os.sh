#!/usr/bin/env bash

# Copyright (C) 2026 Shunt
# SPDX-License-Identifier: GPL-3.0-or-later

# ==============================================================================
# Operating System Helpers
# ==============================================================================

dw::os::is_wsl() {
  grep -qi microsoft /proc/version 2>/dev/null
}

dw::os::distribution() {

  if [[ -f /etc/os-release ]]; then
    . /etc/os-release
    printf "%s\n" "${ID}"
    return
  fi

  printf "unknown\n"
}

dw::os::require_ubuntu() {

  local distro

  distro="$(dw::os::distribution)"

  if [[ "${distro}" != "${SUPPORTED_DISTRO}" ]]; then
    dw::logger::fatal "Unsupported distribution: ${distro}"
  fi
}

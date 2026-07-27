#!/usr/bin/env bash

# Copyright (C) 2026 Shunt
# SPDX-License-Identifier: GPL-3.0-or-later

# ==============================================================================
# Installer Framework
# ==============================================================================

dw::installer::run() {

  local installer="$1"

  dw::logger::section "${installer}"

  if "dw::installer::${installer}::installed"; then

    dw::logger::success "${installer} already installed."

  else

    dw::logger::info "Installing ${installer}..."

    "dw::installer::${installer}::install"

    if "dw::installer::${installer}::installed"; then

      dw::logger::success "${installer} installed."

    else

      dw::logger::warning "${installer} is not available yet."

    fi

  fi

  if declare -F "dw::installer::${installer}::configure" >/dev/null; then

    dw::logger::info "Configuring ${installer}..."

    "dw::installer::${installer}::configure"

  fi

}

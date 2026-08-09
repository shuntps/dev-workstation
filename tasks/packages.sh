#!/usr/bin/env bash

# Copyright (C) 2026 Shunt
# SPDX-License-Identifier: MIT

# ==============================================================================
# Base Packages
# ==============================================================================

dw::task::packages() {

  dw::logger::section "Base Packages"

  dw::apt::install "${BASE_PACKAGES[@]}"

}

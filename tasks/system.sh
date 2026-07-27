#!/usr/bin/env bash

# Copyright (C) 2026 Shunt
# SPDX-License-Identifier: GPL-3.0-or-later

# ==============================================================================
# System Tasks
# ==============================================================================

dw::task::system() {

  dw::logger::section "System"

  dw::apt::update
  dw::apt::upgrade
  dw::apt::autoremove
  dw::apt::autoclean
}

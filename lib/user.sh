#!/usr/bin/env bash

# Copyright (C) 2026 Shunt
# SPDX-License-Identifier: MIT

# ==============================================================================
# User Helpers
# ==============================================================================

dw::user::require_sudo() {

  if ! sudo -v; then
    dw::logger::fatal "Unable to acquire sudo privileges."
  fi
}

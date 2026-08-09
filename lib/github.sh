#!/usr/bin/env bash

# Copyright (C) 2026 Shunt
# SPDX-License-Identifier: MIT

# ==============================================================================
# GitHub API Helpers
# ==============================================================================

dw::github::latest_tag() {

  local repo="$1"

  curl -fsSL "https://api.github.com/repos/${repo}/releases/latest" |
    grep -Po '"tag_name": *"v\K[^"]*'

}

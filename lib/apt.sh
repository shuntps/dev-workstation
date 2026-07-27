#!/usr/bin/env bash

# Copyright (C) 2026 Shunt
# SPDX-License-Identifier: GPL-3.0-or-later

# ==============================================================================
# APT Package Manager
# ==============================================================================

dw::apt::update() {

  dw::logger::info "Updating package index..."

  sudo apt-get update -y

  dw::logger::success "Package index updated."
}

dw::apt::upgrade() {

  dw::logger::info "Upgrading installed packages..."

  sudo DEBIAN_FRONTEND=noninteractive \
    apt-get full-upgrade -y

  dw::logger::success "System upgraded."
}

dw::apt::autoremove() {

  dw::logger::info "Removing unused packages..."

  sudo apt-get autoremove -y

  dw::logger::success "Unused packages removed."
}

dw::apt::autoclean() {

  dw::logger::info "Cleaning package cache..."

  sudo apt-get autoclean -y

  dw::logger::success "Package cache cleaned."
}

dw::apt::install() {

  local package
  local missing=()

  for package in "$@"; do

    if dw::apt::is_installed "${package}"; then
      dw::logger::info "${package} already installed."
    else
      missing+=("${package}")
    fi

  done

  if [[ "${#missing[@]}" -eq 0 ]]; then
    return
  fi

  dw::logger::info "Installing ${missing[*]}..."

  sudo DEBIAN_FRONTEND=noninteractive \
    apt-get install -y "${missing[@]}"

  dw::logger::success "${missing[*]} installed."
}

dw::apt::is_installed() {

  dpkg -s "$1" >/dev/null 2>&1

}

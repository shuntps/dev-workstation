#!/usr/bin/env bash

# Copyright (C) 2026 Shunt
# SPDX-License-Identifier: GPL-3.0-or-later

# ==============================================================================
# GitHub Connection
# ==============================================================================

dw::installer::github::installed() {

  dw::command::exists gh && gh auth status >/dev/null 2>&1

}

dw::installer::github::install() {

  dw::logger::info "Not connected to GitHub. Launching interactive login..."

  gh auth login --hostname github.com --git-protocol "${GH_GIT_PROTOCOL}" ||
    dw::logger::warning "GitHub login was not completed. Re-run 'gh auth login' to connect."

}

dw::installer::github::configure() {

  dw::installer::github::verify_ssh

}

dw::installer::github::verify_ssh() {

  if [[ "${GH_GIT_PROTOCOL}" != "ssh" ]]; then

    return

  fi

  if ssh -T git@github.com \
    -o BatchMode=yes \
    -o StrictHostKeyChecking=accept-new \
    -o ConnectTimeout=10 2>&1 | grep -q "successfully authenticated"; then

    dw::logger::success "SSH access to GitHub confirmed."

  else

    dw::logger::warning "SSH access to GitHub could not be confirmed."
    dw::logger::warning "Add your public key at: https://github.com/settings/keys"

  fi

}

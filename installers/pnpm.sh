#!/usr/bin/env bash

# Copyright (C) 2026 Shunt
# SPDX-License-Identifier: GPL-3.0-or-later

# ==============================================================================
# pnpm Installer (corepack)
# ==============================================================================

dw::installer::pnpm::installed() {

  dw::command::exists pnpm

}

dw::installer::pnpm::install() {

  dw::installer::pnpm::ensure_corepack

  corepack enable

}

dw::installer::pnpm::configure() {

  corepack prepare pnpm@latest --activate

}

dw::installer::pnpm::ensure_corepack() {

  if dw::command::exists corepack; then

    return

  fi

  npm install -g corepack

}

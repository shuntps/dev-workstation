#!/usr/bin/env bash

# Copyright (C) 2026 Shunt
# SPDX-License-Identifier: GPL-3.0-or-later

source "${DW_ROOT_DIR}/tasks/system.sh"
source "${DW_ROOT_DIR}/tasks/packages.sh"

dw::task::install() {

  dw::task::system

  dw::task::packages

  dw::installer::run git

  dw::installer::run ssh

  dw::installer::run gh

  dw::installer::run github

  dw::installer::run node

  dw::installer::run pnpm

  dw::installer::run bun

  dw::installer::run python

  dw::installer::run docker

  dw::installer::run fonts

  dw::installer::run terminal

  dw::installer::run starship

  dw::installer::run lazygit

  dw::installer::run direnv

}

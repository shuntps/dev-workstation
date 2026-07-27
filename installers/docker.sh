#!/usr/bin/env bash

# Copyright (C) 2026 Shunt
# SPDX-License-Identifier: GPL-3.0-or-later

# ==============================================================================
# Docker Installer (Docker Desktop / WSL Integration)
# ==============================================================================

dw::installer::docker::installed() {

  dw::command::exists docker && docker info >/dev/null 2>&1

}

dw::installer::docker::install() {

  dw::logger::warning "Docker Desktop WSL integration is not detected."
  dw::logger::warning "Enable it from: Docker Desktop > Settings > Resources > WSL Integration."
  dw::logger::warning "Then re-run bootstrap."

}

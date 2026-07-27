#!/usr/bin/env bash

# Copyright (C) 2026 Shunt
# SPDX-License-Identifier: GPL-3.0-or-later

# ==============================================================================
# Dev Workstation
# Bootstrap
# ==============================================================================

set -Eeuo pipefail

START_TIME="$(date +%s)"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ------------------------------------------------------------------------------
# Load Libraries
# ------------------------------------------------------------------------------

source "${SCRIPT_DIR}/lib/common.sh"

# ------------------------------------------------------------------------------
# Error Handling
# ------------------------------------------------------------------------------

dw::bootstrap::on_error() {

  local exit_code="$1"
  local line="$2"

  dw::logger::error "Bootstrap failed."
  dw::logger::error "Exit code : ${exit_code}"
  dw::logger::error "Line      : ${line}"

  exit "${exit_code}"
}

trap 'dw::bootstrap::on_error $? $LINENO' ERR

# ------------------------------------------------------------------------------
# Validation
# ------------------------------------------------------------------------------

dw::bootstrap::validate() {

  dw::logger::section "Validation"

  dw::command::require bash
  dw::command::require sudo
  dw::command::require apt-get
  dw::command::require grep
  dw::command::require date

  dw::os::require_ubuntu

  dw::user::require_sudo

  dw::logger::success "Environment validated."
}

# ------------------------------------------------------------------------------
# Summary
# ------------------------------------------------------------------------------

dw::bootstrap::summary() {

  local end_time
  local duration

  end_time="$(date +%s)"
  duration="$((end_time - START_TIME))"

  dw::logger::section "Completed"

  dw::logger::success "Bootstrap completed successfully."

  printf "\n"
  printf "Version  : %s\n" "${WORKSTATION_VERSION}"
  printf "Duration : %ss\n" "${duration}"

  if dw::os::is_wsl; then
    printf "Platform : WSL\n"
  else
    printf "Platform : Linux\n"
  fi

  printf "Distro   : %s\n" "$(dw::os::distribution)"
}

# ------------------------------------------------------------------------------
# Main
# ------------------------------------------------------------------------------

main() {

  dw::logger::section "${WORKSTATION_NAME}"

  dw::bootstrap::validate

  dw::task::install

  dw::bootstrap::summary
}

main "$@"

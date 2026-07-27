#!/usr/bin/env bash

# Copyright (C) 2026 Shunt
# SPDX-License-Identifier: GPL-3.0-or-later

# ==============================================================================
# Dev Workstation
# Logger Library
# ==============================================================================

readonly DW_COLOR_RESET="\033[0m"

readonly DW_COLOR_RED="\033[0;31m"
readonly DW_COLOR_GREEN="\033[0;32m"
readonly DW_COLOR_YELLOW="\033[0;33m"
readonly DW_COLOR_BLUE="\033[0;34m"
readonly DW_COLOR_CYAN="\033[0;36m"

readonly DW_ICON_INFO="ℹ"
readonly DW_ICON_SUCCESS="✔"
readonly DW_ICON_WARNING="⚠"
readonly DW_ICON_ERROR="✖"

dw::logger::timestamp() {
  date +"%H:%M:%S"
}

dw::logger::print() {
  local color="$1"
  local prefix="$2"
  shift 2

  printf "%b[%s] %s%b %s\n" \
    "${color}" \
    "$(dw::logger::timestamp)" \
    "${prefix}" \
    "${DW_COLOR_RESET}" \
    "$*"
}

dw::logger::info() {
  dw::logger::print \
    "${DW_COLOR_BLUE}" \
    "${DW_ICON_INFO} INFO" \
    "$@"
}

dw::logger::success() {
  dw::logger::print \
    "${DW_COLOR_GREEN}" \
    "${DW_ICON_SUCCESS} OK" \
    "$@"
}

dw::logger::warning() {
  dw::logger::print \
    "${DW_COLOR_YELLOW}" \
    "${DW_ICON_WARNING} WARN" \
    "$@"
}

dw::logger::error() {
  dw::logger::print \
    "${DW_COLOR_RED}" \
    "${DW_ICON_ERROR} ERROR" \
    "$@" >&2
}

dw::logger::fatal() {
  dw::logger::error "$@"
  exit 1
}

dw::logger::section() {
  printf "\n%b========== %s ==========%b\n" \
    "${DW_COLOR_CYAN}" \
    "$*" \
    "${DW_COLOR_RESET}"
}

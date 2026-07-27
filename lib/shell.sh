#!/usr/bin/env bash

# Copyright (C) 2026 Shunt
# SPDX-License-Identifier: GPL-3.0-or-later

# ==============================================================================
# Shell Configuration Helpers
# ==============================================================================

dw::shell::configure_rc() {

  local marker="$1"
  local rc_file="${HOME}/.bashrc"

  shift

  if dw::fs::file_exists "${rc_file}"; then

    dw::shell::remove_rc_block "${marker}" "${rc_file}"

  fi

  {
    printf "\n%s\n" "${marker}"
    printf "%s\n" "$@"
  } >>"${rc_file}"

}

dw::shell::remove_rc_block() {

  local marker="$1"
  local rc_file="$2"
  local tmp_file

  tmp_file="$(mktemp)"

  awk -v marker="${marker}" '
    $0 == marker { skip = 1; next }
    skip == 1 { if (NF == 0) { skip = 0 }; next }
    NF == 0 { if (prev_blank) next; prev_blank = 1; print; next }
    { prev_blank = 0; print }
  ' "${rc_file}" >"${tmp_file}"

  mv "${tmp_file}" "${rc_file}"

}

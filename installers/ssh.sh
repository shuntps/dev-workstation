#!/usr/bin/env bash

# Copyright (C) 2026 Shunt
# SPDX-License-Identifier: GPL-3.0-or-later

# ==============================================================================
# SSH Installer
# ==============================================================================

dw::installer::ssh::installed() {

  dw::command::exists ssh-keygen

}

dw::installer::ssh::install() {

  dw::apt::install openssh-client

}

dw::installer::ssh::configure() {

  local ssh_dir="${HOME}/.ssh"
  local key_path="${ssh_dir}/${SSH_KEY_FILENAME}"

  dw::fs::mkdir "${ssh_dir}"
  chmod "${SSH_DIR_MODE}" "${ssh_dir}"

  if dw::fs::file_exists "${key_path}"; then

    dw::logger::success "SSH key already exists: ${key_path}"

  else

    dw::logger::info "Generating SSH key: ${key_path}"

    ssh-keygen \
      -t "${SSH_KEY_TYPE}" \
      -f "${key_path}" \
      -C "$(dw::installer::ssh::default_comment)" \
      -N "" \
      -q

    dw::logger::success "SSH key generated: ${key_path}"

  fi

  chmod "${SSH_PRIVATE_KEY_MODE}" "${key_path}"
  chmod "${SSH_PUBLIC_KEY_MODE}" "${key_path}.pub"

}

dw::installer::ssh::default_comment() {
  printf "%s@%s\n" "$(whoami)" "$(uname -n)"
}

#!/usr/bin/env bash
set -e

for variable in "$@"; do
  declare "$variable"
  [ -n "${host}" ] && SSH_HOST="${host}"
  [ -n "${user}" ] && SSH_USER="${user}"
  [ -n "${password}" ] && SSH_PASSWORD="${password}"
done

sshpass -p "${SSH_PASSWORD}" scp -P "${SSH_PORT:-22}" "${HOME}/.hosts" "${SSH_USER}@${SSH_HOST}:/root/.hosts"
sshpass -p "${SSH_PASSWORD}" scp -P "${SSH_PORT:-22}" "${HOME}/.ssh/id_rsa" "${SSH_USER}@${SSH_HOST}:/root/.ssh/id_rsa"
sshpass -p "${SSH_PASSWORD}" scp -P "${SSH_PORT:-22}" "${HOME}/.ssh/id_rsa.pub" "${SSH_USER}@${SSH_HOST}:/root/.ssh/id_rsa.pub"
sshpass -p "${SSH_PASSWORD}" scp -P "${SSH_PORT:-22}" "${HOME}/.config/rclone/rclone.conf" "${SSH_USER}@${SSH_HOST}:/root/.config/rclone/rclone.conf"

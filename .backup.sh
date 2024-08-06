#!/usr/bin/env bash
set -e

IAC_RESOURCE=$(echo "$1" | sed 's/\/*$//g')
IAC_VARIABLES=$(grep "^host=[a-z0-9.]* name=.* iac=${IAC_RESOURCE}" "${HOME}/.hosts" | head -1)
IAC_BACKUP_SCRIPT=$1/.backup.sh

if [ -z "${IAC_VARIABLES}" ]; then
  echo "Resource host not found: $1"
  exit 1
fi

if [ ! -f "${IAC_BACKUP_SCRIPT}" ]; then
  echo "Ignore to backup '${IAC_RESOURCE}'. File not found: ${IAC_BACKUP_SCRIPT}"
  exit 0
fi

for variable in ${IAC_VARIABLES}; do
  declare "$variable"
  [ -n "${host}" ] && SSH_HOST="${host}"
  [ -n "${user}" ] && SSH_USER="${user}"
  [ -n "${password}" ] && SSH_PASSWORD="${password}"
done

echo "Backup '${IAC_RESOURCE}' (host=${SSH_HOST})"

IAC_RCLONE_CONFIG=/root/.config/rclone/rclone_backup.conf

## Install rclone
sshpass -p "${SSH_PASSWORD}" ssh -o "StrictHostKeyChecking no" "${SSH_USER}@${SSH_HOST}" -p "${SSH_PORT:-22}" bash -s -- "$IAC_VARIABLES" << 'EOF'
  apt-get update >/dev/null 2>&1
  command -v unzip >/dev/null 2>&1 || apt-get install -y unzip
  command -v rclone >/dev/null 2>&1 || curl https://rclone.org/install.sh | bash
EOF

if [ ! -f "${HOME}/.config/rclone/rclone.conf" ]; then
  echo "Rclone config not found: ${HOME}/.config/rclone/rclone.conf"
  exit 1
fi

## Share rclone config
sshpass -p "${SSH_PASSWORD}" ssh -p "${SSH_PORT:-22}" "${SSH_USER}@${SSH_HOST}" mkdir -p "$(dirname "${IAC_RCLONE_CONFIG}")"
sshpass -p "${SSH_PASSWORD}" scp -P "${SSH_PORT:-22}" "${HOME}/.config/rclone/rclone.conf" "${SSH_USER}@${SSH_HOST}:${IAC_RCLONE_CONFIG}"

## Execute remote backup script
sshpass -p "${SSH_PASSWORD}" ssh -p "${SSH_PORT:-22}" "${SSH_USER}@${SSH_HOST}" bash -s -- "$IAC_VARIABLES pwd=/opt/iac/${IAC_RESOURCE} rclone_config=${IAC_RCLONE_CONFIG}" < "${IAC_BACKUP_SCRIPT}"

## Remove rclone config for security reasons
sshpass -p "${SSH_PASSWORD}" ssh -p "${SSH_PORT:-22}" "${SSH_USER}@${SSH_HOST}" rm -f "${IAC_RCLONE_CONFIG}"

#!/usr/bin/env bash
set -e

IAC_RESOURCE=$(echo "$1" | sed 's/\/*$//g')
IAC_VARIABLES=$(grep "^host=[a-z0-9.]* name=.* iac=${IAC_RESOURCE}" "${HOME}/.hosts" | head -1)

if [ -z "${IAC_VARIABLES}" ]; then
  echo "Resource host not found: $1"
  exit 1
fi

for variable in ${IAC_VARIABLES}; do
  declare "$variable"
  [ -n "${host}" ] && SSH_HOST="${host}"
  [ -n "${user}" ] && SSH_USER="${user}"
  [ -n "${password}" ] && SSH_PASSWORD="${password}"
done

echo "Connect to ${IAC_RESOURCE} (host=${SSH_HOST})"

#echo "Variables: $IAC_VARIABLES"

sshpass -p "${SSH_PASSWORD}" ssh -o "StrictHostKeyChecking no" "${SSH_USER}@${SSH_HOST}" -p "${SSH_PORT:-22}" bash -s -- "$IAC_VARIABLES" << 'EOF'
  apt-get update >/dev/null 2>&1
  command -v git >/dev/null 2>&1 || apt-get install -y git
  test -d /opt/iac || git config --global --add safe.directory /opt/iac
  test -d /opt/iac || git clone https://github.com/francescobianco/iac /opt/iac
  cd /opt/iac
  git pull || true
EOF

echo "Execute commands as ${SSH_USER}"

sshpass -p "${SSH_PASSWORD}" ssh "${SSH_USER}@${SSH_HOST}" -p "${SSH_PORT:-22}" bash -s -- "$IAC_VARIABLES pwd=/opt/iac/${IAC_RESOURCE}"

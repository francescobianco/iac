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



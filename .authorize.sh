#!/usr/bin/env bash
set -e

IAC_RESOURCE=$(echo "$1" | sed 's/\/*$//g')
IAC_VARIABLES=$(grep "^host=[a-z0-9.]* name=.* iac=${IAC_RESOURCE}" "${HOME}/.hosts" | head -1)

if [ -z "${IAC_VARIABLES}" ]; then
  echo "Resource host not found: $1"
  exit 1
fi

IAC_AUTHROIZE_FILE=$1/.authorize.sh

if [ ! -f "${IAC_AUTHROIZE_FILE}" ]; then
  echo "Ignore to authorize '${IAC_RESOURCE}'. File not found: ${IAC_AUTHROIZE_FILE}"
  exit 0
fi

bash "${IAC_AUTHROIZE_FILE}" ${IAC_VARIABLES}

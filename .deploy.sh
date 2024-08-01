#!/usr/bin/env bash
set -e

IAC_RESOURCE=$1
IAC_VARIABLES=$(grep "^host=[a-z0-9.]* iac=$1" "${HOME}/.hosts" | head -1)

if [ -z "${IAC_VARIABLES}" ]; then
  echo "Resource host not found: $1"
  exit 1
fi

echo "Hello World! $IAC_RESOURCE"

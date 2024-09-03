#!/usr/bin/env bash
set -e

for variable in "$@"; do
  declare "$variable"
  [ -n "${pwd}" ] && PWD="${pwd}"
done

cd "${PWD}" || exit 1

make start

echo " - Nodered: http://${host}:1880"
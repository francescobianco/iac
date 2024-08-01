#!/usr/bin/env bash
set -e

for variable in "$@"; do
  declare "$variable"
  [ -n "${pwd}" ] && PWD="${pwd}"
done

cd "${PWD}" || exit 1
echo $PWD
printenv
pwd

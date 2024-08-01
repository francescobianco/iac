#!/usr/bin/env bash
set -e

for variable in "$@"; do
  declare "$variable"
  [ -n "${pwd}" ] && PWD="${pwd}"
  [ -n "${iac}" ] && IAC_RESOURCE="${iac}"
done

cd "${PWD}" || exit 1

rclone sync ./kanboard "gdrive:/Backup/${IAC_RESOURCE}/kanboard" --delete-before

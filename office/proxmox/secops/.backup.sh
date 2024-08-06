#!/usr/bin/env bash
set -e

for variable in "$@"; do
  declare "$variable"
  [ -n "${pwd}" ] && PWD="${pwd}"
  [ -n "${iac}" ] && IAC_RESOURCE="${iac}"
  [ -n "${rclone_config}" ] && export RCLONE_CONFIG="${rclone_config}"
done

cd "${PWD}" || exit 1

rclone -v sync ./cronicle "gdrive:/Backup/iac/${IAC_RESOURCE}/cronicle" --delete-before

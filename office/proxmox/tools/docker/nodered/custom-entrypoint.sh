#!/usr/bin/env bash
set -e

MY_PWD=$(pwd)

cd /data
npm install --unsafe-perm --no-update-notifier --no-fund --only=production

cd "$MY_PWD"
/usr/src/node-red/entrypoint.sh "$@"

#!/bin/sh

set -e

bundle check || bundle install --binstubs="$BUNDLE_BIN"
yarn install --check-files

if [ -f /usr/src/app/tmp/pids/server.pid ]; then
  rm /usr/src/app/tmp/pids/server.pid
fi

bin/dev
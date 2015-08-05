#!/bin/bash

set -ex

npm install

bundle install
bundle exec compass compile -e production --force

if type hugo &>/dev/null; then
  hugo
fi

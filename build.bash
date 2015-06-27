#!/bin/bash

set -ex

npm install

gem install compass
compass compile -e production --force

if type hugo &>/dev/null; then
  hugo
fi

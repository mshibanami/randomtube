#!/bin/bash

set -ex

npm install

gem install compass
compass compile -e production --force

if which hugo &> /dev/null; then
  hugo
fi

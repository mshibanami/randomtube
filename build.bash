#!/bin/bash

set -ex

npm install

gem install compass
compass compile -e production --force

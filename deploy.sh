#!/bin/sh

set -e

echo "\033[0;32mデプロイ中...\033[0m"

compass compile -e production --force

bower update

hugo

if [[ -n $(git status --porcelain) ]]; then
  echo "\033[0;31mデプロイ失敗: コミットされていない変更があります。\033[0m"
  exit 1
fi

git push origin master
git subtree push --prefix=public origin gh-pages

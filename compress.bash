#!/bin/bash

set -e

# CSSファイルの圧縮
# ----------------------------
# TODO: 冗長
styleCss='public/css/compiled/style.css'
size=$(( $(wc -c < $styleCss) / 1024))

./node_modules/purify-css/bin/purifycss $styleCss public/index.html public/[a-z][a-z]/index.html --min --out $styleCss

purifiedSize=$(($(wc -c < $styleCss) / 1024))
echo "$size"kB→"$purifiedSize"kB $styleCss


# HTMLファイルの圧縮
# ----------------------------
ignoreDirs=(
  .*node_modules
  .*bower_components
)
# 対象のHTMLパスを取得
for d in ${ignoreDirs[@]}; do
  ignoreDirsParam=" -not ( -type d -regex $d -prune ) $ignoreDirsParam "
done
htmls=$(find public $ignoreDirsParam -regex '.*\.html$')

# 圧縮
for f in $htmls; do
  size=$(($(wc -c < $f) / 1024))

  ./node_modules/html-minifier/cli.js -c html-minifier.conf -o $f $f

  purifiedSize=$(($(wc -c < $f) / 1024))
  echo "$size"kB→"$purifiedSize"kB $f
done

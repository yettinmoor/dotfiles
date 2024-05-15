#!/usr/bin/env sh

name="$1"

sed -i "s/%NAME/$name/g" .compile
sed -i "s:%DIR:$(realpath .):g" .clangd

ln -s ~/dev/ns src/ns

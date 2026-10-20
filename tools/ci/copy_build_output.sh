#!/bin/bash

mkdir -p \
    $1/icons \
    $1/tgui/public \
    $1/local/icons \

cp effigy.dmb effigy.rsc $1/
cp -r icons/* $1/icons/
cp -r tgui/public/* $1/tgui/public/
cp -r local/icons/* $1/local/icons/ # EffigyEdit Add

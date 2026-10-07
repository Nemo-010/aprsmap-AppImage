#!/bin/sh

set -eu

ARCH=$(uname -m)
export ARCH
export OUTPATH=./dist
export ADD_HOOKS="self-updater.hook"
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export ICON=./aprsmap.png
export DESKTOP=./aprsmap.desktop
export DEPLOY_QT=1

# Deploy dependencies
# librtlsdr is loaded at runtime by APRSMap for its RTL-SDR support, and
# quick-sharun has remapped the hardcoded /usr/lib paths into the AppDir
quick-sharun /usr/bin/aprsmap /usr/lib/librtlsdr.so*

# Additional changes can be done in between here

# Turn AppDir into AppImage
quick-sharun --make-appimage

# Test the app for 12 seconds, if the test fails due to the app
# having issues running in the CI use --simple-test instead
quick-sharun --test ./dist/*.AppImage

#!/usr/bin/env bash
# -*- coding: utf-8 -*-

ALIPAY_URL="https://d.alipayobjects.com/sec/edit/wkaliedit.dmg"
ALIPAY_DMG=$(mktemp -d -t alipay_dmg)/alipay.dmg
ALIPAY_MOUNTPOINT=$(mktemp -d -t alipay_mountpoint)

curl -o $ALIPAY_DMG $ALIPAY_URL
hdiutil attach -mountpoint $ALIPAY_MOUNTPOINT -nobrowse $ALIPAY_DMG

ALIPAY_PKG_ARCHIVE="$ALIPAY_MOUNTPOINT/installer.pkg"
ALIPAY_PKG_EXTRACT_DIR=$(mktemp -d -t alipay_pkg_extract_dir)
ALIPAY_INSTALL_SRC="$ALIPAY_PKG_EXTRACT_DIR/output.pkg"

cd "$ALIPAY_PKG_EXTRACT_DIR"
xar -xf "$ALIPAY_PKG_ARCHIVE"

cd "$ALIPAY_INSTALL_SRC"
cat Payload | gunzip -dc | cpio -i

mkdir -p "$HOME/Library/Internet Plug-Ins"
cd "$HOME/Library/Internet Plug-Ins"
rm -rf "$HOME/Library/Internet Plug-Ins/aliedit.plugin"
rm -rf "$HOME/Library/Internet Plug-Ins/npalicdo.plugin"

unzip -o $ALIPAY_INSTALL_SRC/alipay.app/Contents/Resources/aliedit.zip -d "$HOME/Library/Internet Plug-Ins"
unzip -o $ALIPAY_INSTALL_SRC/alipay.app/Contents/Resources/npalicdo.zip -d "$HOME/Library/Internet Plug-Ins"

find aliedit.plugin -type d -exec chmod 755 {} \;
find aliedit.plugin -type f -exec chmod 644 {} \;
find npalicdo.plugin -type d -exec chmod 755 {} \;
find npalicdo.plugin -type f -exec chmod 644 {} \;

hdiutil detach $ALIPAY_MOUNTPOINT -force

cd "$HOME"

rm -rf $ALIPAY_DMG
rm -rf $ALIPAY_MOUNTPOINT
rm -rf $ALIPAY_PKG_EXTRACT_DIR

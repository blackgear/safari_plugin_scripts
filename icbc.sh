#!/usr/bin/env bash
# -*- coding: utf-8 -*-

ICBC_URL="https://mybank.icbc.com.cn/icbc/newperbank/SafeControls.dmg"
ICBC_DMG=$(mktemp -d -t icbc_dmg)/SafeControls.dmg
ICBC_MOUNTPOINT=$(mktemp -d -t icbc_mountpoint)
curl -o $ICBC_DMG $ICBC_URL
hdiutil attach -mountpoint $ICBC_MOUNTPOINT -nobrowse $ICBC_DMG

ICBC_PKG_ARCHIVE="$ICBC_MOUNTPOINT/Setup.pkg"
ICBC_PKG_EXTRACT_DIR=$(mktemp -d -t icbc_pkg_extract_dir)

cd "$ICBC_PKG_EXTRACT_DIR"
xar -xf "$ICBC_PKG_ARCHIVE"

mkdir -p "$HOME/Library/Internet Plug-Ins"
cd "$HOME/Library/Internet Plug-Ins"

rm -rf "$HOME/Library/Internet Plug-Ins/NPCleanHistory.plugin"
rm -rf "$HOME/Library/Internet Plug-Ins/NPClientBinding.plugin"
rm -rf "$HOME/Library/Internet Plug-Ins/NPSafeInput.plugin"
rm -rf "$HOME/Library/Internet Plug-Ins/NPSafeSubmit.plugin"

cat "$ICBC_PKG_EXTRACT_DIR/npcleanhistory.pkg/Payload" | gunzip -dc | cpio -i
cat "$ICBC_PKG_EXTRACT_DIR/npclientbinding.pkg/Payload" | gunzip -dc | cpio -i
cat "$ICBC_PKG_EXTRACT_DIR/npsafeinput.pkg/Payload" | gunzip -dc | cpio -i
cat "$ICBC_PKG_EXTRACT_DIR/npsafesubmit.pkg/Payload" | gunzip -dc | cpio -i

find NPCleanHistory.plugin -type d -exec chmod 755 {} \;
find NPCleanHistory.plugin -type f -exec chmod 644 {} \;
find NPClientBinding.plugin -type d -exec chmod 755 {} \;
find NPClientBinding.plugin -type f -exec chmod 644 {} \;
find NPSafeInput.plugin -type d -exec chmod 755 {} \;
find NPSafeInput.plugin -type f -exec chmod 644 {} \;
find NPSafeSubmit.plugin -type d -exec chmod 755 {} \;
find NPSafeSubmit.plugin -type f -exec chmod 644 {} \;

hdiutil detach $ICBC_MOUNTPOINT -force

cd "$HOME"

rm -rf $ICBC_DMG
rm -rf $ICBC_MOUNTPOINT
rm -rf $ICBC_PKG_EXTRACT_DIR

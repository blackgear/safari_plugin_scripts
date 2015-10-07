#!/usr/bin/env bash
# -*- coding: utf-8 -*-

FLASH_VER=$(/usr/bin/curl -s http://www.adobe.com/software/flash/about/ | sed -n '/Safari/,/<\/tr/s/[^>]*>\([0-9].*\)<.*/\1/p')
FLASH_URL="https://fpdownload.macromedia.com/get/flashplayer/pdc/$FLASH_VER/install_flash_player_osx.dmg"
FLASH_DMG=$(mktemp -d -t flash_dmg)/flash.dmg
FLASH_MOUNTPOINT=$(mktemp -d -t flash_mountpoint)

curl -o $FLASH_DMG $FLASH_URL
hdiutil attach -mountpoint $FLASH_MOUNTPOINT -nobrowse $FLASH_DMG

FLASH_PKG_ARCHIVE="$FLASH_MOUNTPOINT/Install Adobe Flash Player.app/Contents/Resources/Adobe Flash Player.pkg"
FLASH_PKG_EXTRACT_DIR=$(mktemp -d -t flash_pkg_extract_dir)
FLASH_INSTALL_SRC="$FLASH_PKG_EXTRACT_DIR/AdobeFlashPlayerComponent.pkg"

cd "$FLASH_PKG_EXTRACT_DIR"
xar -xf "$FLASH_PKG_ARCHIVE"

cd "$FLASH_INSTALL_SRC"
cat Payload | gunzip -dc | cpio -i
cat Scripts | gunzip -dc | cpio -i

mkdir -p "$HOME/Library/Internet Plug-Ins"

cp -f "$FLASH_INSTALL_SRC/Library/Internet Plug-Ins/Flash Player.plugin.lzma" "$HOME/Library/Internet Plug-Ins"
cp -f "$FLASH_INSTALL_SRC/Library/Internet Plug-Ins/flashplayer.xpt" "$HOME/Library/Internet Plug-Ins"

"$FLASH_INSTALL_SRC/finalize" "$HOME"

find "$HOME/Library/Internet Plug-Ins/Flash Player.plugin" -type d -exec chmod 755 {} \;
find "$HOME/Library/Internet Plug-Ins/Flash Player.plugin" -type f -exec chmod 644 {} \;
chmod 644 "$HOME/Library/Internet Plug-Ins/flashplayer.xpt"

hdiutil detach $FLASH_MOUNTPOINT -force

cd "$HOME"

rm -rf $FLASH_DMG
rm -rf $FLASH_MOUNTPOINT
rm -rf $FLASH_PKG_EXTRACT_DIR

#!/bin/bash
TARGET=ctop
GITHUB_REPO=bcicen/ctop

DOWNLOAD_PATH=/tmp/$TARGET
DEST_PATH=/usr/local/bin/$TARGET

# Determine the latest release
REPO_RELEASE=$(curl --silent "https://api.github.com/repos/$GITHUB_REPO/releases/latest" | grep -Po '"tag_name": "\K.*?(?=")')

# Download the release from GitHub and install it in /usr/local/bin
rm -f $DOWNLOAD_PATH
PKG_URL=https://github.com/$GITHUB_REPO/releases/download/$REPO_RELEASE/$TARGET-$(echo $REPO_RELEASE | cut -c 2-)-$(uname -s | tr '[:upper:]' '[:lower:]')-$(uname -m | sed s/x86_64/amd64/)
curl -L $PKG_URL > $DOWNLOAD_PATH
sudo install $DOWNLOAD_PATH $DEST_PATH

whereis $TARGET
$TARGET -v

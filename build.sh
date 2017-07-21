#!/usr/bin/env sh

set -e

if [ -z "$(ls -A /assets)" ]; then
  echo "The directory /assets is not mounted to emojione-assets, so cloning it..."
  git clone --depth 1 https://github.com/emojione/emojione-assets /assets
fi

# Copy over the assets for further processing
cd /root/emojione-android
mkdir png
cp -R /assets/png/128 png/

# Rename image files
/rename_files.py /assets/emoji.json /root/emojione-android/png/128

# Build the font and put it on host
NOCOMPRESSING=1 make
mv EmojiOne.ttf /fonts/emojione-android.ttf

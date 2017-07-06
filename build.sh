#!/usr/bin/env sh

if [ -z "$(ls -A /assets)" ]; then
  echo "The directory /assets is not mounted to emojione-assets, so cloning it..."
  git clone --depth 1 https://github.com/emojione/emojione-assets /assets
fi

cd /root/emojione-android
mkdir png
cp -R /assets/png/128 png/

NOCOMPRESSING=1 make

mv EmojiOne.ttf /fonts/

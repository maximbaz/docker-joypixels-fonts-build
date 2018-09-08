#!/bin/sh

if ! find /assets -mindepth 1 -maxdepth 1 | read; then
  echo "==> The directory /assets is not mounted to emojione-assets, so cloning it..."
  git clone --depth 1 https://github.com/emojione/emojione-assets /assets
fi

echo "==> Copying assets for further processing..."
cd /root/emojione-android
mkdir -p png/128/
cp /assets/png/128/*.png png/128/

echo "==> Renaming image files..."
/rename_files.py /assets/emoji.json /root/emojione-android/png/128

echo "==> Building the font..."
NOCOMPRESSING=1 make

echo "==> Saving the font file on the host..."
mv EmojiOne.ttf /fonts/emojione-android.ttf

echo "==> Copying alternative assets for further processing..."
rm -rf png
mkdir -p png/128/
cp /assets/png/128/*.png png/128/
cp /assets/png/128/_alt/*.png png/128/

echo "==> Renaming image files..."
/rename_files.py /assets/emoji.json /root/emojione-android/png/128

echo "==> Building the alternative font..."
NOCOMPRESSING=1 make

echo "==> Saving the alternative font file on the host..."
mv EmojiOne.ttf /fonts/emojione-android-alt.ttf

#!/bin/sh

if ! find /assets -mindepth 1 -maxdepth 1 | read c; then
  echo "==> The directory /assets is not mounted to joypixels/emoji-assets, so cloning it..."
  git clone --depth 1 https://github.com/joypixels/emoji-assets /assets
fi

echo "==> Activating the build environment..."
cd /root/joypixels-emoji
. bin/activate

echo "==> Copying assets for further processing..."
mkdir -p png/128/
cp /assets/png/128/*.png png/128/

echo "==> Renaming image files..."
/rename_files.py /assets/emoji.json /root/joypixels-emoji/png/128

echo "==> Validating the sequences..."
make -j check_sequence || true

echo "==> Building the font..."
make -j BYPASS_SEQUENCE_CHECK=True

echo "==> Saving the font file(s) on the host..."
mv joypixels-emoji.ttf joypixels-emoji-windows.ttf /fonts/

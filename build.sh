#!/usr/bin/env sh

if [ -z "$(ls -A /assets)" ]; then
  echo "The directory /assets is not mounted to emojione-assets, so cloning it..."
  git clone --depth 1 https://github.com/emojione/emojione-assets /assets
fi

# Copy over the assets for further processing
cd /root/emojione-android
mkdir png
cp -R /assets/png/128 png/

# Rename image files - the bruteforce way
cd /root/emojione-android/png/128
for f in *.png; do
  mv "$f" "`echo $f | sed 's/-\(1f308\|1f33e\|1f373\|1f393\|1f3a4\|1f3a8\|1f3eb\|1f3ed\|1f466\|1f467\|1f468\|1f469\|1f48b\|1f4bb\|1f4bc\|1f527\|1f52c\|1f5e8\|1f680\|1f692\|2640\|2642\|2695\|2696\|2708\|2764\)/-200d-\1/g'`" 2>/dev/null;
done
cd /root/emojione-android

# Build the font and put it on host
NOCOMPRESSING=1 make
mv EmojiOne.ttf /fonts/emojione-android.ttf

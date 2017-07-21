#!/usr/bin/env python2

import json
import sys
import os
import os.path

if len(sys.argv) != 3:
    print("Usage: ./rename_files.py <path-to-emoji.json> <path-to-png-128>")
    sys.exit(1)

emoji_json_path = sys.argv[1]
images_path = sys.argv[2]

if not os.path.isfile(emoji_json_path):
    print("The path '{}' is not a file.".format(emoji_json_path))
    sys.exit(1)

if not os.path.isdir(images_path):
    print("The path '{}' is not a directory.".format(images_path))
    sys.exit(1)

metadata = json.load(open(emoji_json_path))
images = os.listdir(images_path)

for img in images:
    img_name = img[:-4]
    img_ext = img[-4:]
    if img_name not in metadata:
        print("No metadata for image file '{}' in '{}', aborting.".format(
            img_name, emoji_json_path))
        sys.exit(1)
    old_img_path = os.path.join(images_path, img)
    new_img_path = os.path.join(
        images_path,
        metadata[img_name]['code_points']['non_fully_qualified'] + img_ext)
    os.rename(old_img_path, new_img_path)

print("Images were renamed successfully.")

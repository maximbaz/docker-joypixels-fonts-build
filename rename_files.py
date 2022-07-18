#!/usr/bin/env python

import json
import os
import os.path
import sys

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

success = True

for img in images:
    img_name = img[:-4]
    img_ext = img[-4:]
    if img_ext != ".png":
        print("Skipping file '{}', it doesn't look like a png image.".format(img))
        continue
    if img_name not in metadata:
        print(
            "No metadata for image file '{}' in '{}'".format(img_name, emoji_json_path)
        )
        success = False
        continue
    if "code_points" not in metadata[img_name]:
        print(
            "No code_points metadata for image file '{}' in '{}'".format(
                img_name, emoji_json_path
            )
        )
        success = False
        continue
    if "base" not in metadata[img_name]["code_points"]:
        print(
            "No 'base' code_point for image file '{}' in '{}'".format(
                img_name, emoji_json_path
            )
        )
        success = False
        continue
    old_img_path = os.path.join(images_path, img)
    new_img_path = os.path.join(
        images_path, metadata[img_name]["code_points"]["base"] + img_ext
    )
    os.rename(old_img_path, new_img_path)

if success:
    print("Images were renamed successfully.")
else:
    print("There was an error while renaming images, aborting.")
    sys.exit(1)

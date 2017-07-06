[![Build Status](https://travis-ci.org/maximbaz/docker-emojione-fonts-build.svg?branch=master)](https://travis-ci.org/maximbaz/docker-emojione-fonts-build)

# Build EmojiOne font files

## Usage:

This will clone the `emojione-assets` repository and use it to compile the fonts:

```
$ docker pull maximbaz/emojione-fonts-build
$ docker run --rm -v $(pwd):/fonts maximbaz/emojione-fonts-build
```

If you have `emojione-assets` already available, use the following commands:

```
$ docker pull maximbaz/emojione-fonts-build
$ docker run --rm -v $(pwd):/fonts -v /path/to/emojione-assets:/assets maximbaz/emojione-fonts-build
```

The compiled fonts will be placed in the current directory on the host.


## Supported fonts

The image can currently build the following fonts:

- `emojione-android.ttf` for Android and Linux.

---------

* Based on [base/devel](https://hub.docker.com/r/base/devel/) image.
* Updated daily with [Travis cron job](https://travis-ci.org/maximbaz/docker-emojione-fonts-build).
* Sources are on [Github](https://github.com/maximbaz/docker-emojione-fonts-build).

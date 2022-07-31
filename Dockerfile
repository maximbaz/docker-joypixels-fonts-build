FROM archlinux:latest

VOLUME /fonts /assets

RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen && \
    locale-gen && \
    pacman -Sy --noconfirm --needed libffi git make python python-pip which zopfli pkgconf clang cairo imagemagick && \
    git clone --depth 1 https://github.com/maximbaz/joypixels-emoji.git /root/joypixels-emoji && \
    cd /root/joypixels-emoji && \
    python -m venv . && \
    . bin/activate && \
    pip install -r requirements.txt

ADD build.sh rename_files.py /

ENTRYPOINT ["/build.sh"]

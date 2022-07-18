FROM archlinux:latest

VOLUME /fonts /assets

RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen && \
    locale-gen && \
    pacman -Sy --noconfirm --needed libffi git make python python-pip which && \
    pip install fonttools && \
    git clone --depth 1 https://github.com/googlei18n/nototools /root/nototools && \
    cd /root/nototools && \
    LANG=en_US.UTF-8 python setup.py develop && \
    git clone --depth 1 https://github.com/maximbaz/joypixels-android.git /root/joypixels-android

ADD build.sh rename_files.py /

ENTRYPOINT ["/build.sh"]

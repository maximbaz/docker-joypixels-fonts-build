FROM archlinux:latest

# WORKAROUND for glibc 2.33 and old Docker
# See https://github.com/actions/virtual-environments/issues/2658
# Thanks to https://github.com/lxqt/lxqt-panel/pull/1562
RUN patched_glibc=glibc-linux4-2.33-4-x86_64.pkg.tar.zst && \
    curl -LO "https://repo.archlinuxcn.org/x86_64/$patched_glibc" && \
    bsdtar -C / -xvf "$patched_glibc"

VOLUME /fonts /assets

RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen && \
    locale-gen && \
    pacman -Sy --noconfirm --needed libffi git make python2 python2-pip which && \
    pip2 install fonttools && \
    git clone --depth 1 https://github.com/googlei18n/nototools /root/nototools && \
    cd /root/nototools && \
    LANG=en_US.UTF-8 python2 setup.py develop && \
    git clone --depth 1 https://github.com/maximbaz/joypixels-android.git /root/joypixels-android

ADD build.sh rename_files.py /

ENTRYPOINT ["/build.sh"]

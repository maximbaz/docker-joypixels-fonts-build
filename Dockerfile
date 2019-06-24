FROM archlinux/base:latest

VOLUME /fonts /assets

# required by nototools
RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
RUN locale-gen

RUN pacman -Sy --noconfirm git python2 python2-pip
RUN pip2 install fonttools

RUN git clone --depth 1 https://github.com/googlei18n/nototools /root/nototools
RUN cd /root/nototools; LANG=en_US.UTF-8 python2 setup.py develop

RUN git clone --depth 1 https://github.com/maximbaz/joypixels-android.git /root/joypixels-android

ADD build.sh /build.sh
ADD rename_files.py /rename_files.py
ENTRYPOINT ["/build.sh"]

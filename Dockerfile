FROM ubuntu

VOLUME /fonts /assets

RUN apt update -y && apt upgrade -y && apt install -y libffi-dev git make cargo python3-venv python-is-python3 zopfli pkgconf clang libcairo2-dev imagemagick
RUN git clone --depth 1 https://github.com/maximbaz/joypixels-emoji.git /root/joypixels-emoji && \
    cd /root/joypixels-emoji && \
    python -m venv . && \
    . bin/activate && \
    pip install -r requirements.txt

ADD build.sh rename_files.py /

ENTRYPOINT ["/build.sh"]

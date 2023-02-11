FROM alpine:3.16

ARG TAG=3.0.0Alpha76

RUN \
  apk add libcurl libstdc++ libxft ncurses && \
  apk add --virtual .build autoconf-archive automake curl curl-dev g++ git gnu-libiconv libxft-dev make ncurses-dev pkgconfig unzip && \
  git clone --depth=1 --recurse-submodules --branch ${TAG} https://github.com/hengband/hengband.git && \
  ( \
    cd hengband && \
    sed -i -e 's/NKF/ICONV/g' -e 's/nkf/gnu-iconv/g' configure.ac && \
    sed -i -e 's/nkf -e/gnu-iconv -c -f utf-8 -t euc-jp/' src/gcc-wrap && \
    ./bootstrap && \
    ./configure --enable-xft --prefix=/usr --with-setgid=games && \
    make && \
    make install \
  ) && \
  rm -rf hengband && \
  curl -sL https://ja.osdn.net/dl/hengband/heng-graf-16x16.tar.gz | tar zxC /usr/share/games/hengband/lib/xtra/graf  && \
  mkdir -p /usr/share/fonts/noto && \
  curl -sLO https://github.com/googlefonts/noto-cjk/releases/download/Sans2.004/11_NotoSansMonoCJKjp.zip && \
  unzip 11_NotoSansMonoCJKjp.zip -d /usr/share/fonts/noto && \
  rm -f 11_NotoSansMonoCJKjp.zip && \
  apk del --purge .build

ENV ANGBAND_X11_FONT=monospace DISPLAY=host.docker.internal:0
#ENV XMODIFIERS=@im=kinput2

VOLUME /root/.angband/Hengband
VOLUME /usr/share/games/hengband/lib/bone
VOLUME /usr/share/games/hengband/lib/data
VOLUME /usr/share/games/hengband/lib/info
VOLUME /usr/share/games/hengband/lib/save
VOLUME /usr/share/games/hengband/lib/script
VOLUME /usr/share/games/hengband/lib/user

ENTRYPOINT ["/usr/bin/hengband"]
CMD ["-mgcu"]

FROM alpine

ARG TAG=3.0.0Alpha70

RUN \
  apk add libcurl libstdc++ ncurses && \
  apk add --virtual .build autoconf-archive automake curl-dev g++ git gnu-libiconv make ncurses-dev pkgconfig && \
  git clone --depth=1 --recurse-submodules --branch ${TAG} https://github.com/hengband/hengband.git && \
  ( \
    cd hengband && \
    sed -i -e 's/NKF/ICONV/g' -e 's/nkf/gnu-iconv/g' configure.ac && \
    sed -i -e 's/nkf -e/gnu-iconv -c -f utf-8 -t euc-jp/' src/gcc-wrap && \
    ./bootstrap && \
    ./configure --prefix=/usr --with-setgid=games && \
    make && \
    make install \
  ) && \
  rm -rf hengband && \
  apk del --purge .build

VOLUME /root/.angband/Hengband
VOLUME /usr/share/games/hengband/lib/bone
VOLUME /usr/share/games/hengband/lib/data
VOLUME /usr/share/games/hengband/lib/info
VOLUME /usr/share/games/hengband/lib/save
VOLUME /usr/share/games/hengband/lib/script
VOLUME /usr/share/games/hengband/lib/user

ENTRYPOINT ["/usr/bin/hengband"]

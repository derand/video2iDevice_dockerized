#
# Based on https://hub.docker.com/r/jrottenberg/ffmpeg/~/dockerfile/ 
#  + added libass
#

# docker build --rm -t derand/ffmpeg_build .
# docker run -it --name ffmpeg_build derand/ffmpeg_build

FROM        debian:jessie
MAINTAINER  Andrei Derevyagin <2derand@gmail.com>

ENV         FFMPEG_VERSION=3.1.4 \
            FAAC_VERSION=1.28    \
            FDKAAC_VERSION=0.1.4 \
            LAME_VERSION=3.99.5  \
            OGG_VERSION=1.3.2    \
            OPUS_VERSION=1.1.1   \
            THEORA_VERSION=1.1.1 \
            YASM_VERSION=1.3.0   \
            VORBIS_VERSION=1.3.5 \
            VPX_VERSION=1.6.0    \
            XVID_VERSION=1.3.4   \
            X265_VERSION=2.0     \
            X264_VERSION=20160826-2245-stable \
            PKG_CONFIG_PATH=/usr/local/lib/pkgconfig \
            SRC=/usr/local

RUN     export buildDeps="autoconf \
                    automake \
                    cmake \
                    curl \
                    bzip2 \
                    g++ \
                    gcc \
                    libtool \
                    make \
                    nasm \
                    perl \
                    pkg-config \
                    python \
                    libssl-dev \
                    zlib1g-dev" && \
        export MAKEFLAGS="-j$(($(nproc) + 1))" && \
        apt-get -yqq update && \
        apt-get install -yq --no-install-recommends ${buildDeps} ca-certificates && \
        apt-get install -yq --no-install-recommends libass-dev && \

        DIR=$(mktemp -d) && cd ${DIR} && \
## yasm http://yasm.tortall.net/
        curl -sL https://github.com/yasm/yasm/archive/v${YASM_VERSION}.tar.gz | \
        tar -zx --strip-components=1 && \
        ./autogen.sh && \
        ./configure --prefix="${SRC}" --bindir="${SRC}/bin" --datadir=${DIR} && \
        make && \
        make install && \
#        make distclean && \
#        rm -rf ${DIR} && \
        DIR=$(mktemp -d) && cd ${DIR} && \
## x264 http://www.videolan.org/developers/x264.html
        curl -sL https://ftp.videolan.org/pub/videolan/x264/snapshots/x264-snapshot-${X264_VERSION}.tar.bz2 | \
        tar -jx --strip-components=1 && \
        ./configure --prefix="${SRC}" --bindir="${SRC}/bin" --enable-static && \
        make && \
        make install && \
#        make distclean && \
#        rm -rf ${DIR} && \
        DIR=$(mktemp -d) && cd ${DIR} && \
## x265 http://x265.org/
        curl -sL https://download.videolan.org/pub/videolan/x265/x265_${X265_VERSION}.tar.gz  | \
        tar -zx && \
        cd x265_${X265_VERSION}/build/linux && \
        ./multilib.sh && \
        make -C 8bit install && \
#        rm -rf ${DIR} && \
        DIR=$(mktemp -d) && cd ${DIR} && \
## libogg https://www.xiph.org/ogg/
        curl -sL http://downloads.xiph.org/releases/ogg/libogg-${OGG_VERSION}.tar.gz | \
        tar -zx --strip-components=1 && \
        ./configure --prefix="${SRC}" --bindir="${SRC}/bin" --disable-shared --datadir=${DIR} && \
        make && \
        make install && \
#        make distclean && \
#        rm -rf ${DIR} && \
        DIR=$(mktemp -d) && cd ${DIR} && \
## libopus https://www.opus-codec.org/
        curl -sL http://downloads.xiph.org/releases/opus/opus-${OPUS_VERSION}.tar.gz | \
        tar -zx --strip-components=1 && \
        autoreconf -fiv && \
        ./configure --prefix="${SRC}" --disable-shared --datadir="${DIR}" && \
        make && \
        make install && \
#        make distclean && \
#        rm -rf ${DIR} && \
        DIR=$(mktemp -d) && cd ${DIR} && \
## libvorbis https://xiph.org/vorbis/
        curl -sL http://downloads.xiph.org/releases/vorbis/libvorbis-${VORBIS_VERSION}.tar.gz | \
        tar -zx --strip-components=1 && \
        ./configure --prefix="${SRC}" --with-ogg="${SRC}" --bindir="${SRC}/bin" \
        --disable-shared --datadir="${DIR}" && \
        make && \
        make install && \
#        make distclean && \
#        rm -rf ${DIR} && \
        DIR=$(mktemp -d) && cd ${DIR} && \
#@ libtheora http://www.theora.org/
        curl -sL http://downloads.xiph.org/releases/theora/libtheora-${THEORA_VERSION}.tar.bz2 | \
        tar -jx --strip-components=1 && \
        ./configure --prefix="${SRC}" --with-ogg="${SRC}" --bindir="${SRC}/bin" \
        --disable-shared --datadir="${DIR}" && \
        make && \
        make install && \
#        make distclean && \
#        rm -rf ${DIR} && \
        DIR=$(mktemp -d) && cd ${DIR} && \
## libvpx https://www.webmproject.org/code/
        curl -sL https://codeload.github.com/webmproject/libvpx/tar.gz/v${VPX_VERSION} | \
        tar -zx --strip-components=1 && \
        ./configure --prefix="${SRC}" --enable-vp8 --enable-vp9 --disable-examples --disable-docs && \
        make && \
        make install && \
#        make clean && \
#        rm -rf ${DIR} && \
        DIR=$(mktemp -d) && cd ${DIR} && \
## libmp3lame http://lame.sourceforge.net/
        curl -sL https://downloads.sf.net/project/lame/lame/${LAME_VERSION%.*}/lame-${LAME_VERSION}.tar.gz | \
        tar -zx --strip-components=1 && \
        ./configure --prefix="${SRC}" --bindir="${SRC}/bin" --disable-shared --enable-nasm --datadir="${DIR}" && \
        make && \
        make install && \
#        make distclean&& \
#        rm -rf ${DIR} && \
        DIR=$(mktemp -d) && cd ${DIR} && \
## faac https://sourceforge.net/projects/faac/ +  http://stackoverflow.com/a/4320377
        curl -sL https://downloads.sf.net/faac/faac-${FAAC_VERSION}.tar.gz | \
        tar -zx --strip-components=1 && \
        sed -i '126d' common/mp4v2/mpeg4ip.h && \
        ./bootstrap && \
        ./configure --prefix="${SRC}" --bindir="${SRC}/bin" --datadir="${DIR}" && \
        make && \
        make install && \
#        rm -rf ${DIR} && \
        DIR=$(mktemp -d) && cd ${DIR} && \
## xvid https://www.xvid.com/
        curl -sL http://downloads.xvid.org/downloads/xvidcore-${XVID_VERSION}.tar.gz | \
        tar -zx && \
        cd xvidcore/build/generic && \
        ./configure --prefix="${SRC}" --bindir="${SRC}/bin" --datadir="${DIR}" && \
        make && \
        make install && \
#        rm -rf ${DIR} && \
        DIR=$(mktemp -d) && cd ${DIR} && \
## fdk-aac https://github.com/mstorsjo/fdk-aac
        curl -sL https://github.com/mstorsjo/fdk-aac/archive/v${FDKAAC_VERSION}.tar.gz | \
        tar -zx --strip-components=1 && \
        autoreconf -fiv && \
        ./configure --prefix="${SRC}" --disable-shared --datadir="${DIR}" && \
        make && \
        make install && \
#        make distclean && \
#        rm -rf ${DIR} && \
        DIR=$(mktemp -d) && cd ${DIR} && \
## ffmpeg https://ffmpeg.org/
        curl -sL http://ffmpeg.org/releases/ffmpeg-${FFMPEG_VERSION}.tar.gz | \
        tar -zx --strip-components=1 && \
        ./configure --prefix="${SRC}" \
        --extra-cflags="-I${SRC}/include" \
        --extra-ldflags="-L${SRC}/lib" \
        --bindir="${SRC}/bin" \
        --disable-doc \
        --extra-libs=-ldl \
        --enable-version3 \
        --enable-libfaac \
        --enable-libfdk_aac \
        --enable-libmp3lame \
        --enable-libopus \
        --enable-libtheora \
        --enable-libvorbis \
        --enable-libvpx \
        --enable-libx264 \
        --enable-libx265 \
        --enable-libxvid \
        --enable-libass \
        --enable-gpl \
        --enable-avresample \
        --enable-postproc \
        --enable-nonfree \
        --disable-debug \
        --enable-small \
        --enable-openssl && \
        make && \
        make install && \
#        cd tools && \
#        make qt-faststart && \
#        cp qt-faststart ${SRC}/bin && \
        mv /usr/local/lib/libxvidcore.so* /usr/local/lib/libx265.so* /usr/local/lib/libfaac.so* /usr/lib/ && \
        ffmpeg -buildconf && \
        rm -fr /tmp/* && \
# fonts
        mkdir /usr/share/fonts/root_fonts && \
        ln -s /usr/share/fonts/root_fonts /root/.fonts && \
#
        curl -sL https://dl.dropboxusercontent.com/u/2200287/fonts.tar.gz | \
        tar -zx --strip-components=1 -C /usr/share/fonts/root_fonts/ && \
        rm -f /ffmpeg.tar.gz && \
        tar -zcvf /ffmpeg.tar.gz /usr/lib/x86_64-linux-gnu/libass.so* /lib/x86_64-linux-gnu/libc.so.6 /lib/x86_64-linux-gnu/libc-2.19.so /usr/lib/x86_64-linux-gnu/libcrypto.so* /lib/x86_64-linux-gnu/libdl* /usr/lib/x86_64-linux-gnu/libenca.so* /lib/x86_64-linux-gnu/libexpat.so.1* /usr/lib/libfaac.so* /usr/lib/x86_64-linux-gnu/libfontconfig.so* /usr/lib/x86_64-linux-gnu/libfreetype.so* /usr/lib/x86_64-linux-gnu/libfribidi.so* /lib/x86_64-linux-gnu/libgcc_s.so.1 /lib/x86_64-linux-gnu/libglib-2.0.so.0* /usr/lib/x86_64-linux-gnu/libgraphite2.so.* /usr/lib/x86_64-linux-gnu/libharfbuzz*.so* /lib/x86_64-linux-gnu/libm-2.19.so /lib/x86_64-linux-gnu/libm.so.6 /lib/x86_64-linux-gnu/libpcre.so.3* /lib/x86_64-linux-gnu/libpng12.so.0* /lib/x86_64-linux-gnu/libpthread-2.19.so /lib/x86_64-linux-gnu/libpthread.so.0 /lib/x86_64-linux-gnu/librt-2.19.so /lib/x86_64-linux-gnu/librt.so.1 /usr/lib/x86_64-linux-gnu/libssl.so* /usr/lib/x86_64-linux-gnu/libstdc++.so.6* /usr/lib/libx265.so* /usr/lib/libxvidcore.so* /lib/x86_64-linux-gnu/libz.so.1* /usr/local/bin/ffmpeg /usr/share/fontconfig /usr/share/fonts /root/.fonts

CMD ["echo", "Now copy \"/ffmpeg.tar.gz\" to main forlder from container"]
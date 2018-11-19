#
# Based on https://hub.docker.com/r/jrottenberg/ffmpeg/~/dockerfile/ 
#  + added libass
#

# docker build --rm -t derand/ffmpeg .
# docker run -it --name ffmpeg_build derand/ffmpeg_build


FROM        debian:jessie as build
MAINTAINER  Andrei Derevyagin <2derand@gmail.com>

ENV         FFMPEG_VERSION=3.4.4 \
            FAAC_VERSION=1.29    \
            FDKAAC_VERSION=0.1.6 \
            LAME_VERSION=3.100   \
            OGG_VERSION=1.3.3    \
            OPUS_VERSION=1.3     \
            THEORA_VERSION=1.1.1 \
            YASM_VERSION=1.3.0   \
            VORBIS_VERSION=1.3.6 \
            VPX_VERSION=1.7.0    \
            XVID_VERSION=1.3.5   \
            X265_VERSION=2.0     \
            X264_VERSION=20181003-2245-stable \
            NASM_VERSION=2.13.03 \
            PKG_CONFIG_PATH=/usr/local/lib/pkgconfig \
            SRC=/usr/local

RUN     apt-get -yqq update && \
        apt-get install -yq --no-install-recommends \
                    autoconf \
                    automake \
                    cmake \
                    curl \
                    bzip2 \
                    g++ \
                    gcc \
                    libtool \
                    make \
#                    nasm \
                    perl \
                    pkg-config \
                    python \
                    libssl-dev \
                    zlib1g-dev \
                    ca-certificates \
                    libass-dev \
                    xz-utils

## yasm http://yasm.tortall.net/
RUN     DIR=$(mktemp -d) && cd ${DIR} && \
        curl -sL https://github.com/yasm/yasm/archive/v${YASM_VERSION}.tar.gz | tar -zx --strip-components=1 && \
        ./autogen.sh && \
        ./configure --prefix="${SRC}" --bindir="${SRC}/bin" --datadir=${DIR} && \
        make -j"$(nproc)" && \
        make install
#        make distclean && \
#        rm -rf ${DIR}

## nasm http://www.videolan.org/developers/x264.html
RUN     DIR=$(mktemp -d) && cd ${DIR} && \
        curl -sL http://www.nasm.us/pub/nasm/releasebuilds/${NASM_VERSION}/nasm-${NASM_VERSION}.tar.xz | tar -xJv --strip-components=1 && \
        sed -e '/seg_init/d'                      \
            -e 's/pure_func seg_alloc/seg_alloc/' \
            -i include/nasmlib.h && \
        ./configure --prefix="${SRC}" --bindir="${SRC}/bin" && \
        make -j"$(nproc)" && \
        make install
#        make distclean && \
#        rm -rf ${DIR}

## x264 http://www.videolan.org/developers/x264.html
RUN     DIR=$(mktemp -d) && cd ${DIR} && \
        curl -sL http://ftp.videolan.org/pub/videolan/x264/snapshots/x264-snapshot-${X264_VERSION}.tar.bz2 | tar -jx --strip-components=1 && \
        ./configure --prefix="${SRC}" --bindir="${SRC}/bin" --enable-static && \
        make -j"$(nproc)" && \
        make install
#        make distclean && \
#        rm -rf ${DIR}

## x265 http://x265.org/
RUN     DIR=$(mktemp -d) && cd ${DIR} && \
        curl -sL https://download.videolan.org/pub/videolan/x265/x265_${X265_VERSION}.tar.gz  | tar -zx && \
        cd x265_${X265_VERSION}/build/linux && \
        ./multilib.sh &&\
        make -C 8bit install
#        rm -rf ${DIR}

## libogg https://www.xiph.org/ogg/
RUN     DIR=$(mktemp -d) && cd ${DIR} && \
        curl -sL http://downloads.xiph.org/releases/ogg/libogg-${OGG_VERSION}.tar.gz | tar -zx --strip-components=1 && \
        ./configure --prefix="${SRC}" --bindir="${SRC}/bin" --disable-shared --datadir=${DIR} && \
        make -j"$(nproc)" && \
        make install
#        make distclean && \
#        rm -rf ${DIR}

## libopus https://www.opus-codec.org/
RUN     DIR=$(mktemp -d) && cd ${DIR} && \
        curl -sL https://ftp.osuosl.org/pub/xiph/releases/opus/opus-${OPUS_VERSION}.tar.gz | tar -zx --strip-components=1 && \
        autoreconf -fiv && \
        ./configure --prefix="${SRC}" --disable-shared --datadir="${DIR}" && \
        make -j"$(nproc)" && \
        make install
#        make distclean && \
#        rm -rf ${DIR}

## libvorbis https://xiph.org/vorbis/
RUN     DIR=$(mktemp -d) && cd ${DIR} && \
        curl -sL http://downloads.xiph.org/releases/vorbis/libvorbis-${VORBIS_VERSION}.tar.gz | tar -zx --strip-components=1 && \
        ./configure --prefix="${SRC}" --with-ogg="${SRC}" --bindir="${SRC}/bin" \
        --disable-shared --datadir="${DIR}" && \
        make -j"$(nproc)" && \
        make install
#        make distclean && \
#        rm -rf ${DIR}

## libtheora http://www.theora.org/
RUN     DIR=$(mktemp -d) && cd ${DIR} && \
        curl -sL http://downloads.xiph.org/releases/theora/libtheora-${THEORA_VERSION}.tar.bz2 | tar -jx --strip-components=1 && \
        ./configure --prefix="${SRC}" --with-ogg="${SRC}" --bindir="${SRC}/bin" \
        --disable-shared --datadir="${DIR}" && \
        make -j"$(nproc)" && \
        make install
#        make distclean && \
#        rm -rf ${DIR}

## libvpx https://www.webmproject.org/code/
RUN     DIR=$(mktemp -d) && cd ${DIR} && \
        curl -sL https://github.com/webmproject/libvpx/archive/v${VPX_VERSION}.tar.gz | tar -zx --strip-components=1 && \
        ./configure --prefix="${SRC}" --enable-vp8 --enable-vp9 --disable-examples --disable-docs && \
        make -j"$(nproc)" && \
        make install
#        make clean && \
#        rm -rf ${DIR}

## libmp3lame http://lame.sourceforge.net/
RUN     DIR=$(mktemp -d) && cd ${DIR} && \
#        curl -sL https://downloads.sf.net/project/lame/lame/${LAME_VERSION%.*}/lame-${LAME_VERSION}.tar.gz | \
        curl -sL https://downloads.sf.net/project/lame/lame/${LAME_VERSION}/lame-${LAME_VERSION}.tar.gz | tar -zx --strip-components=1 && \
        ./configure --prefix="${SRC}" --bindir="${SRC}/bin" --disable-shared --enable-nasm --datadir="${DIR}" && \
        make -j"$(nproc)" && \
        make install
#        make distclean&& \
#        rm -rf ${DIR}

### faac https://sourceforge.net/projects/faac/ +  http://stackoverflow.com/a/4320377
#RUN     DIR=$(mktemp -d) && cd ${DIR} && \
#        curl -sL https://downloads.sf.net/faac/faac-${FAAC_VERSION}.tar.gz | tar -zx --strip-components=1 && \
#        sed -i '126d' common/mp4v2/mpeg4ip.h && \
#        ./bootstrap && \
#        ./configure --prefix="${SRC}" --bindir="${SRC}/bin" --datadir="${DIR}" && \
#        make -j"$(nproc)" && \
#        make install
##        rm -rf ${DIR}

## xvid https://www.xvid.com/
RUN     DIR=$(mktemp -d) && cd ${DIR} && \
        curl -sL http://downloads.xvid.org/downloads/xvidcore-${XVID_VERSION}.tar.gz | tar -zx && \
        cd xvidcore/build/generic && \
        ./configure --prefix="${SRC}" --bindir="${SRC}/bin" --datadir="${DIR}" && \
        make -j"$(nproc)" && \
        make install
#        rm -rf ${DIR}

## fdk-aac https://github.com/mstorsjo/fdk-aac
RUN     DIR=$(mktemp -d) && cd ${DIR} && \
        curl -sL https://github.com/mstorsjo/fdk-aac/archive/v${FDKAAC_VERSION}.tar.gz | tar -zx --strip-components=1 && \
        autoreconf -fiv && \
        ./configure --prefix="${SRC}" --disable-shared --datadir="${DIR}" && \
        make -j"$(nproc)" && \
        make install
#        make distclean && \
#        rm -rf ${DIR}

## ffmpeg https://ffmpeg.org/
RUN     DIR=$(mktemp -d) && cd ${DIR} && \
        curl -sL http://ffmpeg.org/releases/ffmpeg-${FFMPEG_VERSION}.tar.gz | tar -zx --strip-components=1 && \
        ./configure --prefix="${SRC}" \
        --extra-cflags="-I${SRC}/include" \
        --extra-ldflags="-L${SRC}/lib" \
        --bindir="${SRC}/bin" \
        --disable-doc \
        --extra-libs=-ldl \
        --extra-version="derand" \
        --enable-version3 \
#        --enable-libfaac \
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
        --enable-openssl \
        --enable-libfreetype && \
        make -j"$(nproc)" && \
        make install && \
#        cd tools && \
#        make qt-faststart && \
#        cp qt-faststart ${SRC}/bin && \
#        mv ${SRC}/lib/libxvidcore.so* ${SRC}/lib/libx265.so* ${SRC}/lib/libfaac.so* /usr/lib/ && \
        if [ "$(ls ${SRC}/lib/libxvidcore.so*)" ]; then mv ${SRC}/lib/libxvidcore.so* /usr/lib/; fi && \
        if [ "$(ls ${SRC}/lib/libx265.so*)" ]; then mv ${SRC}/lib/libx265.so** /usr/lib/; fi && \
        if [ "$(ls ${SRC}/lib/libfaac.so*)" ]; then mv ${SRC}/lib/libfaac.so* /usr/lib/; fi && \
        ffmpeg -buildconf

# fonts
RUN     cd /tmp && \
#        rm -fr /tmp/* && \
        mkdir /usr/share/fonts/root_fonts && \
        ln -s /usr/share/fonts/root_fonts /root/.fonts && \
#
        curl -sL https://github.com/derand/video2iDevice_dockerized/raw/feature/f/fonts.tar.gz | tar -zx --strip-components=1 -C /usr/share/fonts/root_fonts/ && \
        rm -f /ffmpeg.tar.gz && \
        ldd ${SRC}/bin/ff* | grep "=>" | sed 's/^\s*//' | cut -f2 -d\> | cut -f1 -d\( | sed 's/\.so\..*/\.so\*/' | while read line ; do echo $line | xargs -n1; done | sort -u | xargs tar -zcvf /ffmpeg.tar.gz ${SRC}/bin/ff* /usr/share/fontconfig /usr/share/fonts /root/.fonts


FROM  debian:jessie
COPY  --from=build /ffmpeg.tar.gz /
RUN   tar -xvzf ffmpeg.tar.gz && \
      rm /ffmpeg.tar.gz

ENTRYPOINT ['ffmpeg']
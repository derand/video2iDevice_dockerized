#
# Based on https://hub.docker.com/r/jrottenberg/ffmpeg/
#

# docker build --rm -t derand/ffmpeg .
# docker run -it --name ffmpeg_build derand/ffmpeg_build

FROM        alpine AS base

RUN     apk  add --no-cache --update libgcc libstdc++ ca-certificates libressl libcrypto1.1 libgomp expat


FROM        base AS build

WORKDIR     /tmp/workdir

ARG        PKG_CONFIG_PATH=/opt/ffmpeg/lib/pkgconfig
ARG        LD_LIBRARY_PATH=/opt/ffmpeg/lib
ARG        PREFIX=/opt/ffmpeg
ARG        MAKEFLAGS="-j2"

ENV         OPENCOREAMR_VERSION=0.1.5 \
#            X264_VERSION=20170226-2245-stable \
            X264_VERSION=20191217-2245-stable \
#            X265_VERSION=3.2.1          \
            OGG_VERSION=1.3.4         \
            OPUS_VERSION=1.3          \
            VORBIS_VERSION=1.3.6      \
            THEORA_VERSION=1.1.1      \
#            VPX_VERSION=1.8.2         \
            LAME_VERSION=3.100       \
            XVID_VERSION=1.3.7        \
            FDKAAC_VERSION=2.0.1      \
            OPENJPEG_VERSION=2.3.1    \
            FREETYPE_VERSION=2.9    \
            LIBVIDSTAB_VERSION=1.1.0  \
            FRIBIDI_VERSION=1.0.8    \
            FONTCONFIG_VERSION=2.13.92 \
            LIBASS_VERSION=0.14.0     \
            KVAZAAR_VERSION=1.3.0     \
            AOM_VERSION=master        \
            FFMPEG_VERSION=4.2      \
            SRC=/usr/local

ARG         OGG_SHA256SUM="fe5670640bd49e828d64d2879c31cb4dde9758681bb664f9bdbf159a01b0c76e  libogg-1.3.4.tar.gz"
ARG         OPUS_SHA256SUM="4f3d69aefdf2dbaf9825408e452a8a414ffc60494c70633560700398820dc550  opus-1.3.tar.gz"
ARG         VORBIS_SHA256SUM="6ed40e0241089a42c48604dc00e362beee00036af2d8b3f46338031c9e0351cb  libvorbis-1.3.6.tar.gz"
ARG         THEORA_SHA256SUM="40952956c47811928d1e7922cda3bc1f427eb75680c3c37249c91e949054916b  libtheora-1.1.1.tar.gz"
ARG         XVID_SHA256SUM="abbdcbd39555691dd1c9b4d08f0a031376a3b211652c0d8b3b8aa9be1303ce2d  xvidcore-1.3.7.tar.gz"
ARG         FREETYPE_SHA256SUM="bf380e4d7c4f3b5b1c1a7b2bf3abb967bda5e9ab480d0df656e0e08c5019c5e6  freetype-2.9.tar.gz"
ARG         LIBVIDSTAB_SHA256SUM="14d2a053e56edad4f397be0cb3ef8eb1ec3150404ce99a426c4eb641861dc0bb  v1.1.0.tar.gz"
ARG         LIBASS_SHA256SUM="82e70ee1f9afe2e54ab4bf6510b83bb563fcb2af978f0f9da82e2dbc9ae0fd72  0.14.0.tar.gz"
ARG         FRIBIDI_SHA256SUM="94c7b68d86ad2a9613b4dcffe7bbeb03523d63b5b37918bdf2e4ef34195c1e6c  fribidi-1.0.8.tar.bz2"


RUN     buildDeps="autoconf \
                   automake \
                   bash \
                   binutils \
                   bzip2 \
                   cmake \
                   curl \
                   coreutils \
                   diffutils \
                   file \
                   g++ \
                   gcc \
                   gperf \
                   libtool \
                   make \
                   python \
                   openssl-dev \
                   tar \
                   yasm \
                   zlib-dev \
                   expat-dev \
                   freetype-dev" && \
        apk  add --no-cache --update ${buildDeps}
## opencore-amr https://sourceforge.net/projects/opencore-amr/
RUN \
        DIR=/tmp/opencore-amr && \
        mkdir -p ${DIR} && \
        cd ${DIR} && \
        curl -sLk https://kent.dl.sourceforge.net/project/opencore-amr/opencore-amr/opencore-amr-${OPENCOREAMR_VERSION}.tar.gz | \
        tar -zx --strip-components=1 && \
        ./configure --prefix="${PREFIX}" --enable-shared  && \
        make && \
        make install && \
        rm -rf ${DIR}
## x264 http://www.videolan.org/developers/x264.html
RUN \
        DIR=/tmp/x264 && \
        mkdir -p ${DIR} && \
        cd ${DIR} && \
        curl -sL https://download.videolan.org/pub/videolan/x264/snapshots/x264-snapshot-${X264_VERSION}.tar.bz2 | \
        tar -jx --strip-components=1 && \
        ./configure --prefix="${PREFIX}" --enable-shared --enable-pic --disable-cli --host=arm-unknown-linux-gnueabi --disable-opencl && \
        make && \
        make install && \
        rm -rf ${DIR}
### x265 http://x265.org/
#RUN \
#        DIR=/tmp/x265 && \
#        mkdir -p ${DIR} && \
#        cd ${DIR} && \
#        curl -sL https://download.videolan.org/pub/videolan/x265/x265_${X265_VERSION}.tar.gz  | \
#        tar -zx && \
#        cd x265_${X265_VERSION}/build/linux && \
#        sed -i "/-DEXTRA_LIB/ s/$/ -DCMAKE_INSTALL_PREFIX=\${PREFIX}/" multilib.sh && \
#        sed -i "/^cmake/ s/$/ -DENABLE_CLI=OFF/" multilib.sh && \
#        ./multilib.sh && \
#        make -C 8bit install && \
#        rm -rf ${DIR}
### libogg https://www.xiph.org/ogg/
RUN \
        DIR=/tmp/ogg && \
        mkdir -p ${DIR} && \
        cd ${DIR} && \
        curl -sLO http://downloads.xiph.org/releases/ogg/libogg-${OGG_VERSION}.tar.gz && \
        echo ${OGG_SHA256SUM} | sha256sum --check && \
        tar -zx --strip-components=1 -f libogg-${OGG_VERSION}.tar.gz && \
        ./configure --prefix="${PREFIX}" --enable-shared  && \
        make && \
        make install && \
        rm -rf ${DIR}
### libopus https://www.opus-codec.org/
RUN \
        DIR=/tmp/opus && \
        mkdir -p ${DIR} && \
        cd ${DIR} && \
        curl -sLO https://archive.mozilla.org/pub/opus/opus-${OPUS_VERSION}.tar.gz && \
        echo ${OPUS_SHA256SUM} | sha256sum --check && \
        tar -zx --strip-components=1 -f opus-${OPUS_VERSION}.tar.gz && \
        autoreconf -fiv && \
        ./configure --prefix="${PREFIX}" --enable-shared && \
        make && \
        make install && \
        rm -rf ${DIR}
### libvorbis https://xiph.org/vorbis/
RUN \
        DIR=/tmp/vorbis && \
        mkdir -p ${DIR} && \
        cd ${DIR} && \
        curl -sLO http://downloads.xiph.org/releases/vorbis/libvorbis-${VORBIS_VERSION}.tar.gz && \
        echo ${VORBIS_SHA256SUM} | sha256sum --check && \
        tar -zx --strip-components=1 -f libvorbis-${VORBIS_VERSION}.tar.gz && \
        ./configure --prefix="${PREFIX}" --with-ogg="${PREFIX}" --enable-shared && \
        make && \
        make install && \
        rm -rf ${DIR}
### libtheora http://www.theora.org/
#RUN \
#        DIR=/tmp/theora && \
#        mkdir -p ${DIR} && \
#        cd ${DIR} && \
#        curl -sLO http://downloads.xiph.org/releases/theora/libtheora-${THEORA_VERSION}.tar.gz && \
#        echo ${THEORA_SHA256SUM} | sha256sum --check && \
#        tar -zx --strip-components=1 -f libtheora-${THEORA_VERSION}.tar.gz && \
#        ./configure --prefix="${PREFIX}" --with-ogg="${PREFIX}" --enable-shared && \
#        make && \
#        make install && \
#        rm -rf ${DIR}
### libvpx https://www.webmproject.org/code/
#RUN \
#        DIR=/tmp/vpx && \
#        mkdir -p ${DIR} && \
#        cd ${DIR} && \
#        curl -sL https://codeload.github.com/webmproject/libvpx/tar.gz/v${VPX_VERSION} | \
#        tar -zx --strip-components=1 && \
#        ./configure --prefix="${PREFIX}" --enable-vp8 --enable-vp9 --enable-vp9-highbitdepth --enable-pic --enable-shared \
#        --disable-debug --disable-examples --disable-docs --disable-install-bins  && \
#        make && \
#        make install && \
#        rm -rf ${DIR}
### libmp3lame http://lame.sourceforge.net/
RUN \
        DIR=/tmp/lame && \
        mkdir -p ${DIR} && \
        cd ${DIR} && \
        curl -sLk https://kent.dl.sourceforge.net/project/lame/lame/$(echo ${LAME_VERSION} | sed -e 's/[^0-9]*\([0-9]*\)[.]\([0-9]*\)[.]\([0-9]*\)\([0-9A-Za-z-]*\)/\1.\2/')/lame-${LAME_VERSION}.tar.gz | \
        tar -zx --strip-components=1 && \
        ./configure --prefix="${PREFIX}" --bindir="${PREFIX}/bin" --enable-shared --enable-nasm --enable-pic --disable-frontend && \
        make && \
        make install && \
        rm -rf ${DIR}
### xvid https://www.xvid.com/
RUN \
        DIR=/tmp/xvid && \
        mkdir -p ${DIR} && \
        cd ${DIR} && \
        curl -sLO https://downloads.xvid.com/downloads/xvidcore-${XVID_VERSION}.tar.gz && \
        echo ${XVID_SHA256SUM} | sha256sum --check && \
        tar -zx -f xvidcore-${XVID_VERSION}.tar.gz && \
        cd xvidcore/build/generic && \
        ./configure --prefix="${PREFIX}" --bindir="${PREFIX}/bin" --datadir="${DIR}" --enable-shared --enable-shared && \
        make && \
        make install && \
        rm -rf ${DIR}
### fdk-aac https://github.com/mstorsjo/fdk-aac
RUN \
        DIR=/tmp/fdk-aac && \
        mkdir -p ${DIR} && \
        cd ${DIR} && \
        curl -sL https://github.com/mstorsjo/fdk-aac/archive/v${FDKAAC_VERSION}.tar.gz | \
        tar -zx --strip-components=1 && \
        autoreconf -fiv && \
        ./configure --prefix="${PREFIX}" --enable-shared --datadir="${DIR}" && \
        make && \
        make install && \
        rm -rf ${DIR}
## openjpeg https://github.com/uclouvain/openjpeg
RUN \
        DIR=/tmp/openjpeg && \
        mkdir -p ${DIR} && \
        cd ${DIR} && \
        curl -sL https://github.com/uclouvain/openjpeg/archive/v${OPENJPEG_VERSION}.tar.gz | \
        tar -zx --strip-components=1 && \
        cmake -DBUILD_THIRDPARTY:BOOL=ON -DCMAKE_INSTALL_PREFIX="${PREFIX}" . && \
        make && \
        make install && \
        rm -rf ${DIR}
## freetype https://www.freetype.org/
RUN  \
        DIR=/tmp/freetype && \
        mkdir -p ${DIR} && \
        cd ${DIR} && \
        curl -sLO http://download.savannah.gnu.org/releases/freetype/freetype-${FREETYPE_VERSION}.tar.gz && \
        echo ${FREETYPE_SHA256SUM} | sha256sum --check && \
        tar -zx --strip-components=1 -f freetype-${FREETYPE_VERSION}.tar.gz && \
        ./configure --prefix="${PREFIX}" --disable-static --enable-shared && \
        make && \
        make install && \
        rm -rf ${DIR}
## libvstab https://github.com/georgmartius/vid.stab
RUN  \
        DIR=/tmp/vid.stab && \
        mkdir -p ${DIR} && \
        cd ${DIR} && \
        curl -sLO https://github.com/georgmartius/vid.stab/archive/v${LIBVIDSTAB_VERSION}.tar.gz &&\
        echo ${LIBVIDSTAB_SHA256SUM} | sha256sum --check && \
        tar -zx --strip-components=1 -f v${LIBVIDSTAB_VERSION}.tar.gz && \
        cmake -DCMAKE_INSTALL_PREFIX="${PREFIX}" . && \
        make && \
        make install && \
        rm -rf ${DIR}
## fridibi https://www.fribidi.org/
# + https://github.com/fribidi/fribidi/issues/8
RUN  \
        DIR=/tmp/fribidi && \
        mkdir -p ${DIR} && \
        cd ${DIR} && \
#        curl -sLO https://github.com/fribidi/fribidi/archive/${FRIBIDI_VERSION}.tar.gz && \
        curl -sLO https://github.com/fribidi/fribidi/releases/download/v${FRIBIDI_VERSION}/fribidi-${FRIBIDI_VERSION}.tar.bz2 && \
        echo ${FRIBIDI_SHA256SUM} | sha256sum --check && \
        tar -jx --strip-components=1 -f fribidi-${FRIBIDI_VERSION}.tar.bz2 && \
#        sed -i 's/^SUBDIRS =.*/SUBDIRS=gen.tab charset lib/' Makefile.am && \
#        ./bootstrap --no-config && \
        ./autogen.sh && \
        ./configure -prefix="${PREFIX}" --disable-static --enable-shared && \
        make -j 1 && \
        make install && \
        rm -rf ${DIR}
## fontconfig https://www.freedesktop.org/wiki/Software/fontconfig/
RUN  \
        DIR=/tmp/fontconfig && \
        mkdir -p ${DIR} && \
        cd ${DIR} && \
        curl -sLO https://www.freedesktop.org/software/fontconfig/release/fontconfig-${FONTCONFIG_VERSION}.tar.gz && \
        tar -zx --strip-components=1 -f fontconfig-${FONTCONFIG_VERSION}.tar.gz && \
        ./configure -prefix="${PREFIX}" --disable-static --enable-shared && \
        make && \
        make install && \
        rm -rf ${DIR}
## libass https://github.com/libass/libass
#??? configure: error: Either DirectWrite (on Windows), CoreText (on OSX), or Fontconfig (Linux, other) is required. If you really want to compile without a system font provider, add --disable-require-system-font-provider
RUN  \
        DIR=/tmp/libass && \
        mkdir -p ${DIR} && \
        cd ${DIR} && \
        curl -sLO https://github.com/libass/libass/archive/${LIBASS_VERSION}.tar.gz && \
        echo ${LIBASS_SHA256SUM} | sha256sum --check && \
        tar -zx --strip-components=1 -f ${LIBASS_VERSION}.tar.gz && \
        ./autogen.sh && \
        ./configure -prefix="${PREFIX}" --disable-static --enable-shared && \
        make && \
        make install && \
        rm -rf ${DIR}
## kvazaar https://github.com/ultravideo/kvazaar
RUN \
        DIR=/tmp/kvazaar && \
        mkdir -p ${DIR} && \
        cd ${DIR} && \
        curl -sLO https://github.com/ultravideo/kvazaar/archive/v${KVAZAAR_VERSION}.tar.gz && \
        tar -zx --strip-components=1 -f v${KVAZAAR_VERSION}.tar.gz && \
        ./autogen.sh && \
        ./configure -prefix="${PREFIX}" --disable-static --enable-shared && \
        make && \
        make install && \
        rm -rf ${DIR}

#RUN \
#        DIR=/tmp/aom && \
#        mkdir -p ${DIR} && \
#        cd ${DIR} && \
#        curl -sLO https://aomedia.googlesource.com/aom/+archive/${AOM_VERSION}.tar.gz && \
#        tar -zx -f ${AOM_VERSION}.tar.gz && \
#        rm -rf CMakeCache.txt CMakeFiles && \
#        mkdir -p ./aom_build && \
#        cd ./aom_build && \
#        cmake -DCMAKE_INSTALL_PREFIX="${PREFIX}" -DBUILD_SHARED_LIBS=1 .. && \
#        make && \
#        make install && \
#        rm -rf ${DIR}

## ffmpeg https://ffmpeg.org/
RUN  \
        DIR=$(mktemp -d) && cd ${DIR} && \
        curl -sLO https://ffmpeg.org/releases/ffmpeg-${FFMPEG_VERSION}.tar.bz2 && \
        tar -jx --strip-components=1 -f ffmpeg-${FFMPEG_VERSION}.tar.bz2 && \
        ./configure \
        --disable-debug \
        --disable-doc \
        --disable-ffplay \
        --enable-shared \
        --enable-avresample \
        --enable-libopencore-amrnb \
        --enable-libopencore-amrwb \
        --enable-gpl \
        --enable-libass \
        --enable-libfreetype \
        --enable-libvidstab \
        --enable-libmp3lame \
        --enable-libopenjpeg \
        --enable-libopus \
        --enable-libtheora \
        --enable-libvorbis \
#        --enable-libvpx \
#        --enable-libx265 \
        --enable-libxvid \
        --enable-libx264 \
        --enable-nonfree \
        --enable-openssl \
        --enable-libfdk_aac \
        --enable-libkvazaar \
#        --enable-libaom \
        --extra-libs=-lpthread \
        --enable-postproc \
        --enable-small \
        --enable-version3 \
        --extra-cflags="-I${PREFIX}/include" \
        --extra-ldflags="-L${PREFIX}/lib" \
        --extra-libs=-ldl \
        --prefix="${PREFIX}" && \
        make && \
        make install && \
        make distclean && \
        hash -r && \
        cd tools && \
        make qt-faststart && \
        cp qt-faststart ${PREFIX}/bin

RUN \
    ldd ${PREFIX}/bin/ffmpeg | grep opt/ffmpeg | cut -d ' ' -f 3 | xargs -i cp {} /usr/local/lib/ && \
    cp ${PREFIX}/bin/* /usr/local/bin/ && \
    cp -r ${PREFIX}/share/ffmpeg /usr/local/share/ && \
    LD_LIBRARY_PATH=/usr/local/lib ffmpeg -buildconf


### Release Stage
FROM        base AS release
MAINTAINER  Julien Rottenberg <julien@rottenberg.info>

COPY --from=build /usr/local /usr/local

CMD         ["--help"]
ENTRYPOINT  ["ffmpeg"]

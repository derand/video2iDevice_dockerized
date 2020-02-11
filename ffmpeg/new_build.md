
### [CompilationGuide](https://trac.ffmpeg.org/wiki/CompilationGuide/Ubuntu)

PREFIX=/usr/local
BINDIR=$PREFIX/bin

apt-get update -qq && apt-get -y install autoconf automake build-essential cmake git-core libass-dev libfreetype6-dev libsdl2-dev libtool libva-dev libvdpau-dev libvorbis-dev libxcb1-dev libxcb-shm0-dev libxcb-xfixes0-dev pkg-config texinfo wget zlib1g-dev


cd /tmp && wget https://www.nasm.us/pub/nasm/releasebuilds/2.14.02/nasm-2.14.02.tar.bz2 && tar xjvf nasm-2.14.02.tar.bz2 && cd nasm-2.14.02 && ./autogen.sh && PATH="$BINDIR:$PATH" ./configure --prefix="$PREFIX" --bindir="$BINDIR" && make && make install

cd /tmp && wget -O yasm-1.3.0.tar.gz https://www.tortall.net/projects/yasm/releases/yasm-1.3.0.tar.gz && tar xzvf yasm-1.3.0.tar.gz && cd yasm-1.3.0 && ./configure --prefix="$PREFIX" --bindir="$BINDIR" && make && make install


cd /tmp && git -C x264 pull 2> /dev/null || git clone --depth 1 https://code.videolan.org/videolan/x264.git && cd x264 && PATH="$BINDIR:$PATH" PKG_CONFIG_PATH="$PREFIX/lib/pkgconfig" ./configure --prefix="$PREFIX" --bindir="$BINDIR" --enable-static --enable-pic --enable-shared --disable-cli --host=arm-unknown-linux-gnueabi --disable-opencl && PATH="$BINDIR:$PATH" make && make install

# --------------
#apt-get install -y --no-install-recommends mercurial libnuma-dev 
#
#cd /tmp && if cd x265 2> /dev/null; then hg pull && hg update && cd ..; else hg clone https://bitbucket.org/multicoreware/x265; fi && cd x265/build/linux && PATH="$BINDIR:$PATH" cmake -G "Unix Makefiles" -DCMAKE_INSTALL_PREFIX="$PREFIX" -DENABLE_SHARED=off ../../source && PATH="$BINDIR:$PATH" make && make install
# --------------

cd /tmp && git -C libvpx pull 2> /dev/null || git clone --depth 1 https://chromium.googlesource.com/webm/libvpx.git && cd libvpx && PATH="$BINDIR:$PATH" ./configure --prefix="$PREFIX" --disable-examples --disable-unit-tests --enable-vp9-highbitdepth --as=yasm && PATH="$BINDIR:$PATH" make && make install

cd /tmp && git -C fdk-aac pull 2> /dev/null || git clone --depth 1 https://github.com/mstorsjo/fdk-aac && cd fdk-aac && autoreconf -fiv && ./configure --prefix="$PREFIX" --disable-shared && make && make install

cd /tmp && wget -O lame-3.100.tar.gz https://downloads.sourceforge.net/project/lame/lame/3.100/lame-3.100.tar.gz && tar xzvf lame-3.100.tar.gz && cd lame-3.100 && PATH="$BINDIR:$PATH" ./configure --prefix="$PREFIX" --bindir="$BINDIR" --disable-shared --enable-nasm && PATH="$BINDIR:$PATH" make && make install

cd /tmp && git -C opus pull 2> /dev/null || git clone --depth 1 https://github.com/xiph/opus.git && cd opus && ./autogen.sh && ./configure --prefix="$PREFIX" --disable-shared && make && make install

# --------------
#cd /tmp && git -C aom pull 2> /dev/null || git clone --depth 1 https://aomedia.googlesource.com/aom && mkdir -p aom_build && cd aom_build && PATH="$BINDIR:$PATH" cmake -G "Unix Makefiles" -DCMAKE_INSTALL_PREFIX="$PREFIX" -DENABLE_SHARED=off -DENABLE_NASM=on ../aom && PATH="$BINDIR:$PATH" make && make install
# --------------

cd /tmp && wget -O ffmpeg-snapshot.tar.bz2 https://ffmpeg.org/releases/ffmpeg-snapshot.tar.bz2 && tar xjvf ffmpeg-snapshot.tar.bz2 && cd ffmpeg && PATH="$BINDIR:$PATH" PKG_CONFIG_PATH="$PREFIX/lib/pkgconfig" ./configure --prefix="$PREFIX" --pkg-config-flags="--static" --extra-cflags="-I$PREFIX/include" --extra-ldflags="-L$PREFIX/lib" --extra-libs="-lpthread -lm" --bindir="$BINDIR" --enable-gpl --enable-libass --enable-libfdk-aac --enable-libfreetype --enable-libmp3lame --enable-libopus --enable-libvorbis --enable-libvpx --enable-libx264 --enable-nonfree && PATH="$BINDIR:$PATH" make && make install && hash -r

cd /tmp && \
wget -O ffmpeg-snapshot.tar.bz2 https://ffmpeg.org/releases/ffmpeg-snapshot.tar.bz2 && \
tar xjvf ffmpeg-snapshot.tar.bz2 && \
cd ffmpeg && \
PATH="$BINDIR:$PATH" PKG_CONFIG_PATH="$PREFIX/lib/pkgconfig" ./configure \
  --prefix="$PREFIX" \
  --pkg-config-flags="--static" \
  --extra-cflags="-I$PREFIX/include" \
  --extra-ldflags="-L$PREFIX/lib" \
  --extra-libs="-lpthread -lm" \
  --bindir="$BINDIR" \
  --enable-gpl \
#  --enable-libaom \
  --enable-libass \
  --enable-libfdk-aac \
  --enable-libfreetype \
  --enable-libmp3lame \
  --enable-libopus \
  --enable-libvorbis \
  --enable-libvpx \
  --enable-libx264 \
#  --enable-libx265 \
  --enable-nonfree && \
PATH="$BINDIR:$PATH" make && \
make install && \
hash -r

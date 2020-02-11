#
# docker build --rm -t derand/2idevice_build .
# docker run -it --name 2idevice_build derand/2idevice_build 
#

FROM        derand/ffmpeg_build
MAINTAINER  Andrei Derevyagin

ENV LANG=C.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=C.UTF-8 \
    PATH="/video2iDevice:${PATH}"

# fonts
RUN     mkdir /usr/share/fonts/root_fonts && \
        ln -s /usr/share/fonts/root_fonts /root/.fonts && \
        curl -sL https://github.com/derand/video2iDevice_dockerized/raw/feature/f/fonts.tar.gz | tar -zx --strip-components=1 -C /usr/share/fonts/root_fonts/

RUN apt-get install -y --no-install-recommends mkvtoolnix gpac atomicparsley mediainfo unzip locales && \
        curl -sL -o /tmp/2id.zip https://github.com/derand/video2iDevice/archive/develop.zip && \
        unzip /tmp/2id.zip -d / && \
        mv /video2iDevice-develop /video2iDevice && \
        rm -fr /tmp/* /video2iDevice/*.pyc && \
        sed -i '1s/.*/#\!\/usr\/bin\/python/' /video2iDevice/2iDevice.py && \
# locale
        sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
        echo 'LANG="C.UTF-8"'>/etc/default/locale && \
        dpkg-reconfigure --frontend=noninteractive locales && \
        update-locale LANG=C.UTF-8 && \
#  ldd /usr/bin/MP4Box /usr/bin/mkvextract /usr/bin/mkvinfo /usr/bin/mkvmerge /usr/bin/AtomicParsley /usr/bin/mediainfo
#   /usr/bin/python
        mkdir -p /data && \
        echo "export PS1=\"2idevice:\w# \"" > /root/.bashrc && \
        echo "cd /data" >> /root/.bashrc && \
        tar -zcvf /2idevice.tar.gz /video2iDevice /usr/bin/python* /usr/lib/python2.7 /usr/bin/mkvinfo* /etc/alternatives/mkvinfo /usr/bin/mkvextract /usr/bin/mkvmerge /usr/bin/mediainfo /usr/bin/AtomicParsley /usr/bin/MP4Box /usr/lib/x86_64-linux-gnu/libFLAC.so.8* /usr/lib/x86_64-linux-gnu/libGL.so.1* /usr/lib/x86_64-linux-gnu/libGLU.so.1* /usr/lib/x86_64-linux-gnu/libX11-xcb.so.1* /usr/lib/x86_64-linux-gnu/libX11.so.6* /usr/lib/x86_64-linux-gnu/libXau.so.6* /usr/lib/x86_64-linux-gnu/libXdamage.so.1* /usr/lib/x86_64-linux-gnu/libXdmcp.so.6* /usr/lib/x86_64-linux-gnu/libXext.so.6* /usr/lib/x86_64-linux-gnu/libXfixes.so.3* /usr/lib/x86_64-linux-gnu/libXxf86vm.so.1* /usr/lib/x86_64-linux-gnu/libboost_filesystem.so.1.55.0 /usr/lib/x86_64-linux-gnu/libboost_regex.so.1.55.0 /usr/lib/x86_64-linux-gnu/libboost_system.so.1.55.0 /lib/x86_64-linux-gnu/libc-2.19.so /lib/x86_64-linux-gnu/libc.so.6 /lib/x86_64-linux-gnu/libcom_err.so.2* /usr/lib/x86_64-linux-gnu/libcurl-gnutls.so.* /lib/x86_64-linux-gnu/libdl-2.19.so /lib/x86_64-linux-gnu/libdl.so.2 /usr/lib/x86_64-linux-gnu/libdrm.so.2* /usr/lib/x86_64-linux-gnu/libebml.so.4 /lib/x86_64-linux-gnu/libexpat.so.1* /usr/lib/x86_64-linux-gnu/libffi.so.6* /lib/x86_64-linux-gnu/libgcc_s.so.1 /lib/x86_64-linux-gnu/libgcrypt.so.20* /usr/lib/x86_64-linux-gnu/libglapi.so.0* /lib/x86_64-linux-gnu/libglib-2.0.so.0* /usr/lib/x86_64-linux-gnu/libgmp.so.10* /usr/lib/x86_64-linux-gnu/libgnutls-deb0.so.28* /usr/lib/libgpac.so.3* /lib/x86_64-linux-gnu/libgpg-error.so.0* /usr/lib/x86_64-linux-gnu/libgssapi_krb5.so.2* /usr/lib/x86_64-linux-gnu/libhogweed.so.2* /usr/lib/x86_64-linux-gnu/libicudata.so.52* /usr/lib/x86_64-linux-gnu/libicui18n.so.52* /usr/lib/x86_64-linux-gnu/libicuuc.so.52* /usr/lib/x86_64-linux-gnu/libidn.so.11* /usr/lib/x86_64-linux-gnu/libjpeg.so.62* /usr/lib/x86_64-linux-gnu/libk5crypto.so.3* /lib/x86_64-linux-gnu/libkeyutils.so.1* /usr/lib/x86_64-linux-gnu/libkrb5* /usr/lib/x86_64-linux-gnu/liblber-2.4.so.2* /usr/lib/x86_64-linux-gnu/libldap_r-2.4.so.2* /lib/x86_64-linux-gnu/libm-2.19.so /lib/x86_64-linux-gnu/libm.so.6 /usr/lib/x86_64-linux-gnu/libmagic.so.1* /usr/lib/x86_64-linux-gnu/libmatroska.so.6 /usr/lib/x86_64-linux-gnu/libmediainfo.so.0* /usr/lib/x86_64-linux-gnu/libmms.so.0* /usr/lib/x86_64-linux-gnu/libnettle.so.4* /usr/lib/x86_64-linux-gnu/libogg.so.0* /usr/lib/x86_64-linux-gnu/libp11-kit.so.0* /lib/x86_64-linux-gnu/libpcre.so.3* /lib/x86_64-linux-gnu/libpng12.so.0* /lib/x86_64-linux-gnu/libpthread-2.19.so /lib/x86_64-linux-gnu/libpthread.so.0 /lib/x86_64-linux-gnu/libresolv-2.19.so /lib/x86_64-linux-gnu/libresolv.so.2 /lib/x86_64-linux-gnu/librt* /usr/lib/x86_64-linux-gnu/librtmp.so.1 /usr/lib/x86_64-linux-gnu/libsasl2.so.2* /usr/lib/x86_64-linux-gnu/libssh2.so.1* /usr/lib/x86_64-linux-gnu/libstdc++.so.6* /usr/lib/x86_64-linux-gnu/libtasn1.so.6* /usr/lib/x86_64-linux-gnu/libtinyxml2.so.2* /lib/x86_64-linux-gnu/libutil* /usr/lib/x86_64-linux-gnu/libvorbis.so.0* /usr/lib/x86_64-linux-gnu/libxcb-dri* /usr/lib/x86_64-linux-gnu/libxcb-glx.so.0* /usr/lib/x86_64-linux-gnu/libxcb-present.so.0* /usr/lib/x86_64-linux-gnu/libxcb-sync.so.1* /usr/lib/x86_64-linux-gnu/libxcb.so.1* /usr/lib/x86_64-linux-gnu/libxshmfence.so.1* /lib/x86_64-linux-gnu/libz.so.1* /usr/lib/x86_64-linux-gnu/libzen.so.0* /usr/bin/locale /lib64/ld-linux-x86-64.so.2 /lib/x86_64-linux-gnu/ld-2.19.so /etc/default/locale /usr/lib/locale/C.UTF-8 /bin/bash /bin/rbash /etc/bash.bashrc /etc/skel /usr/bin/bashbug /usr/share/menu/bash /lib/x86_64-linux-gnu/libncurses.so.5* /lib/x86_64-linux-gnu/libtinfo.so.5* /data /root/.bashrc

CMD ["echo", "Now copy \"/2idevice.tar.gz\" to main forlder from container"]

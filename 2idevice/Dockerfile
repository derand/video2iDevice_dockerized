#
# docker build --rm -t derand/2idevice .
# docker run -it --volumes-from 2idevice_data --name 2idevice derand/2idevice
#

FROM        derand/ffmpeg
MAINTAINER  Andrei Derevyagin

ENV LANG=C.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=C.UTF-8 \
    PATH="/video2iDevice:${PATH}"

ADD 2idevice.tar.gz /

CMD ["/bin/bash"]

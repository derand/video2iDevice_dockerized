#
# docker build --rm -t derand/2idevice .
# docker run -it --rm derand/2idevice
#

FROM        derand/ffmpeg
MAINTAINER  Andrey Derevyagin

ENV LANG=C.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=C.UTF-8 \
    PATH="/video2iDevice:${PATH}"

ADD 2idevice.tar.gz /

CMD ["/bin/bash"]

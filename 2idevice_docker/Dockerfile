#
# docker build --rm -t derand/2idevice:docker .
# docker run -d --volumes-from 2idevice_data --name 2idevice_docker derand/2idevice:docker
#

FROM docker

ENV TIME_WORK=850 \
    TIME_SLEEP=2050

RUN apk update && \
    apk add tzdata && \
    cp /usr/share/zoneinfo/Europe/Kiev /etc/localtime

CMD ["/data/.docker/entrypoint.sh"]

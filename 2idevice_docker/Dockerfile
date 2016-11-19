#
# docker build --rm -t derand/2idevice:docker .
# docker run -it --rm --volumes-from 2idevice_data derand/2idevice:docker
#

FROM docker

ENV TIME_WORK=850 \
    TIME_SLEEP=2050

CMD ["/data/.docker/entrypoint.sh"]

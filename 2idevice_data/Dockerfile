#
# BUILD-USING:        docker build --rm -t derand/2idevice:data .
# RUN-USING:          docker run -d -v /data --name 2idevice_data derand/2idevice:data
#

FROM busybox

RUN     mkdir -p /data/out
VOLUME  /data

CMD  ["true"]
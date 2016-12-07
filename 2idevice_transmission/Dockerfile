#
# docker build --rm -t derand/2idevice:transmission .
# docker run -d --volumes-from 2idevice_data -p 9091:9091 -p 51413:51413/tcp -p 51413:51413/udp -e "USERNAME=admin" -e "PASSWORD=password" -e "CLIENT_IP=<YOUR_IP_to_web_interface>" --name 2idevice_transmission derand/2idevice:transmission
#

FROM        derand/base
MAINTAINER  Andrei Derevyagin

ENV USERNAME=admin    \
    PASSWORD=password \
    CLIENT_IP=

RUN apk add --update transmission-daemon \
    && rm -rf /var/cache/apk/*

COPY src/ .

EXPOSE 9091 51413/tcp 51413/udp

RUN chmod +x /start-transmission.sh
CMD ["/start-transmission.sh"]

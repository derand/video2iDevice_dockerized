#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd ${DIR}

docker build --rm -t derand/ffmpeg_build ffmpeg_build/ && \
docker run -it --name ffmpeg_build derand/ffmpeg_build && \
docker cp ffmpeg_build:/ffmpeg.tar.gz ffmpeg/ && \
docker rm ffmpeg_build && \

docker build --rm -t derand/ffmpeg ffmpeg/ && \

docker build --rm -t derand/2idevice_build 2idevice_build/ && \
docker run -it --name 2idevice_build derand/2idevice_build && \
docker cp 2idevice_build:/2idevice.tar.gz 2idevice/ && \
docker rm 2idevice_build && \

docker build --rm -t derand/2idevice 2idevice/ && \
#docker run -it --rm --volumes-from 2idevice_data derand/2idevice && \

docker build --rm -t derand/2idevice:data 2idevice_data/ && \
if [ -z "$(docker ps -a | grep 2idevice_data)" ]; then docker run -d -v /data --name 2idevice_data derand/2idevice:data; fi

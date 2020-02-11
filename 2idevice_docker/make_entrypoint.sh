#!/bin/sh

FN="$1"

if [[ -z $FN ]]; then
    echo "You should set cloudhero profile file as param"
    exit 1
fi

if [ ! -f $FN ]; then
    echo "\"$FN\" is not file"
fi

source $FN

echo $DOCKER_CERT_PATH

TMP_FN="/tmp/2idevice_docker.sh"
echo "#!/bin/sh" > $TMP_FN
echo "export DOCKER_CERT_PATH=/data/.docker" >> $TMP_FN
echo "export DOCKER_HOST=$DOCKER_HOST" >> $TMP_FN
echo "export DOCKER_TLS_VERIFY=$DOCKER_TLS_VERIFY" >> $TMP_FN
echo "" >> $TMP_FN
echo "echo \"Works/sleep time: \$TIME_WORK/\$TIME_SLEEP\"" >> $TMP_FN
echo "RESULT=0" >> $TMP_FN
echo "while [ \$RESULT -eq 0 ]; do date && echo -n \"pause \" && docker pause 2idevice && sleep \$TIME_SLEEP && echo -n \"unpause \" && docker unpause 2idevice && sleep \$TIME_WORK; RESULT=\$?; done" >> $TMP_FN
chmod +x $TMP_FN

docker run -it --rm --volumes-from 2idevice_data alpine mkdir -p /data/.docker

docker cp "$DOCKER_CERT_PATH/ca.pem" 2idevice_data:/data/.docker/
docker cp "$DOCKER_CERT_PATH/cert.pem" 2idevice_data:/data/.docker/
docker cp "$DOCKER_CERT_PATH/key.pem" 2idevice_data:/data/.docker/
docker cp "$TMP_FN" 2idevice_data:/data/.docker/entrypoint.sh

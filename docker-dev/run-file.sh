DOCKER_TAG=elkdocker:latest
DOCKER_NAME=docker-dev-elk-test

# cleaup Docker
docker kill $DOCKER_NAME
docker rm $DOCKER_NAME

# setup dirs
DOCKER_BASE=/data
DOCKER_NB=$DOCKER_BASE/$DOCKER_NAME
DOCKER_LOGS=$DOCKER_NB/logs
DOCKER_DATA=$DOCKER_NB/data

EXPOSED_JSON_PORT='5002'
JSON_PORT='5002/udp'
DOCKER_JSON_PORT=$EXPOSED_JSON_PORT:$JSON_PORT
DOCKER_PORTS="-p $DOCKER_JSON_PORT -p 5601:5601 -p 9200:9200 -p 5044:5044 "
DOCKER_ENV="-e ES_HEAP_SIZE\=\"4g\" -e LS_HEAP_SIZE\=\"4g\""
DOCKER_VOL=''

sudo mkdir -p $DOCKER_DATA
sudo mkdir -p $DOCKER_LOGS
sudo chmod -R a+rw $DOCKER_NB

docker build -t $DOCKER_TAG .
# run command not 
echo "docker run $DOCKER_PORTS $DOCKER_VOL -it  $DOCKER_ENV \
           --name $DOCKER_NAME $DOCKER_TAG"
docker run -d $DOCKER_PORTS $DOCKER_VOL -it  $DOCKER_ENV \
           --name $DOCKER_NAME $DOCKER_TAG

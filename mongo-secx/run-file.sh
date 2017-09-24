DOCKER_TAG=mongo:latest
DOCKER_NAME=mongo-secx

# cleaup Docker
docker rm $DOCKER_NAME

# setup dirs
DOCKER_BASE=/data
DOCKER_NB=$DOCKER_BASE/$DOCKER_NAME
DOCKER_LOGS=$DOCKER_NB/logs
DOCKER_DATA=$DOCKER_NB/data

DOCKER_PORTS="-p 27017:27017 "
DOCKER_ENV=""
DOCKER_VOL="-v /opt/mongodb/data/db:/data/db -v /opt/mongodb/data/configdb:/data/configdb "

sudo mkdir -p $DOCKER_DATA
sudo mkdir -p $DOCKER_LOGS
sudo chmod -R a+rw $DOCKER_NB

docker build -t $DOCKER_TAG .
# run command not 
docker run $DOCKER_PORTS $DOCKER_VOL -it  $DOCKER_ENV \
           --name $DOCKER_NAME $DOCKER_TAG


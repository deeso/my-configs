DOCKER_TAG=myredis:latest
DOCKER_NAME=myredis

# setup dirs 
DOCKER_BASE=/data
DOCKER_NB=$DOCKER_BASE/$DOCKER_NAME
DOCKER_LOGS=$DOCKER_NB/logs
DOCKER_DATA=$DOCKER_NB/data

sudo mkdir -p $DOCKER_DATA
sudo mkdir -p $DOCKER_LOGS
sudo chmod -R a+rw $DOCKER_NB

# run command
docker run -p 6379:6379  --name $DOCKER_NAME -v $DOCKER_DATA:/data -v $DOCKER_LOGS:/var/log/redis $DOCKER_TAG

DOCKER_TAG=redis:latest
DOCKER_NAME=redis-misc

# cleaup Docker
docker rm $DOCKER_NAME

# setup dirs 
DOCKER_BASE=/data
DOCKER_NB=$DOCKER_BASE/$DOCKER_NAME
DOCKER_LOGS=$DOCKER_NB/logs
DOCKER_DATA=$DOCKER_NB/data
DOCKER_ENV=''
DOCKER_PORTS='-p 6379:6379 '
DOCKER_VOLS="-v $DOCKER_DATA:/data -v $DOCKER_LOGS:/var/log/redis"

# create the required dirs
sudo mkdir -p $DOCKER_DATA
sudo mkdir -p $DOCKER_LOGS
sudo chmod -R a+rw $DOCKER_NB

docker build -t $DOCKER_TAG .
# run command
docker run -d $DOCKER_PORTS $DOCKER_VOL -it  $DOCKER_ENV \
           --name $DOCKER_NAME $DOCKER_TAG

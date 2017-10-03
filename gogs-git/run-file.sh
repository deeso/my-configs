DOCKER_TAG=gogs:latest
DOCKER_NAME=gogs-git

# cleaup Docker

docker kill $DOCKER_NAME
docker rm $DOCKER_NAME

# db info for gogs
GOGS_DOCKER_DB=gogs-postgres

cd ../$GOGS_DOCKER_DB
sh run-file.sh

cd ../$DOCKER_NAME


# setup dirs 
DOCKER_BASE=/data
DOCKER_NB=$DOCKER_BASE/$DOCKER_NAME
DOCKER_LOGS=$DOCKER_NB/logs
DOCKER_DATA=$DOCKER_NB/data
DOCKER_ENV=''
DOCKER_PORTS=' -p 10022:22 -p 10080:3000 '
DOCKER_VOLS="-v $DOCKER_DATA:/data "


# create the required dirs
sudo mkdir -p $DOCKER_DATA
#sudo mkdir -p $DOCKER_LOGS
sudo chmod -R a+rw $DOCKER_NB

# pull from dockerhup
docker build -t $DOCKER_TAG .
# run command
docker run -d $DOCKER_PORTS --link $GOGS_DOCKER_DB $DOCKER_VOLS -it  $DOCKER_ENV \
           --name $DOCKER_NAME $DOCKER_TAG

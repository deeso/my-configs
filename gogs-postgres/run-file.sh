DOCKER_TAG=postgres:latest
DOCKER_NAME=gogs-postgres


# prep the database script and get secrets
DB_INIT=init.sql
PASSWD_FILE=postgres_secret.key
SECRET=$(cat $PASSWD_FILE)
DOCKER_DB_USER=gogs
DOCKER_DB_PASSWORD=$SECRET
DOCKER_DB_NAME=gogs

echo "CREATE USER $DOCKER_DB_USER WITH PASSWORD '$DOCKER_DB_PASSWORD';" > $DB_INIT
echo "CREATE DATABASE $DOCKER_DB_NAME OWNER $DOCKER_DB_USER;" >> $DB_INIT

echo $(cat Dockerfile.base) > Dockerfile
echo "ADD $DB_INIT /docker-entrypoint-initdb.d/" >> Dockerfile

# cleaup Docker
docker kill $DOCKER_NAME
docker rm $DOCKER_NAME

# setup dirs 
DOCKER_BASE=/data
DOCKER_NB=$DOCKER_BASE/$DOCKER_NAME
DOCKER_LOGS=$DOCKER_NB/logs
DOCKER_DATA=$DOCKER_NB/data
DOCKER_ENV=' -e POSTGRES_PASSWORD=$SECRET'
DOCKER_PORTS=' -p 10023:5432 '
DOCKER_VOL="-v $DOCKER_DATA:/data "



# create the required dirs
sudo mkdir -p $DOCKER_DATA
#sudo mkdir -p $DOCKER_LOGS
sudo chmod -R a+rw $DOCKER_NB

docker build --no-cache -t $DOCKER_TAG .

rm $DB_INIT
rm Dockerfile

# run command
docker run -d $DOCKER_PORTS $DOCKER_VOL -it $DOCKER_ENV \
           --name $DOCKER_NAME $DOCKER_TAG

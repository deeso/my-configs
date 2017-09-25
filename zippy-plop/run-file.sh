DOCKER_TAG=python27:latest
DOCKER_NAME=zippy-plop

# cleaup Docker
docker rm $DOCKER_NAME

# setup dirs
DOCKER_BASE=/data
DOCKER_NB=$DOCKER_BASE/$DOCKER_NAME
DOCKER_LOGS=$DOCKER_NB/logs
DOCKER_DATA=$DOCKER_NB/data

DOCKER_PORTS=""
DOCKER_ENV=""
DOCKER_VOL=""

sudo mkdir -p $DOCKER_DATA
sudo mkdir -p $DOCKER_LOGS
sudo chmod -R a+rw $DOCKER_NB

# clone the syslog-etl project
git clone https://github.com/deeso/zippy-plop.git tmp-zippy-plop
cp tmp-zippy-plop/main.py .
rm -rf tmp-zippy-plop


# python script variables
# ****** Important to update the files with the appropriate parameters!!
BROKER_URI="redis://docker-secx:6379"
BROKER_QUEUE="logstash-ingest"

NAME="zippy-plop"

MONGO_HOST="docker-secx"
MSG_LIMIT=100

ETL_HOST="docker-secx"
ETL_PORT=5002
ETL_URI="udp://$ETL_HOST:$ETL_PORT"
ETL_QUEUE=""

# TODO uncomment below if you want to save to Mongo
#echo "python main.py -msave -mhost $MONGO_HOST -mport $MONGO_PORT \
#      -sport $SYSLOG_LISTEN_PORT -known_hosts hosts.txt \
#      -lhost $ETL_HOST -lport $ETL_PORT" > python_cmd.sh

# TODO comment below if you want to save to Mongo
echo "python main.py -msg_limit $MSG_LIMIT \
      -broker_uri $BROKER_URI -broker_queue $BROKER_QUEUE \
      -logstash_uri $ETL_URI -name $NAME"  > python_cmd.sh

cat python_cmd.sh


docker build --no-cache -t $DOCKER_TAG .

# clean up here
rm python_cmd.sh main.py

# run command not 
echo "docker run $DOCKER_PORTS $DOCKER_VOL -it $DOCKER_ENV \
           --name $DOCKER_NAME $DOCKER_TAG"
docker run $DOCKER_PORTS $DOCKER_VOL -it $DOCKER_ENV \
           --name $DOCKER_NAME $DOCKER_TAG

DOCKER_TAG=python27:latest
DOCKER_NAME=slow-hitter

# cleanup Docker
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
git clone https://github.com/deeso/slow-hitter.git tmp-slow-hitter
cp tmp-slow-hitter/main.py .
rm -rf tmp-slow-hitter


# python script variables
# ****** Important to update the files with the appropriate parameters!!
BROKER_URI="redis://docker-secx:6379"
BROKER_QUEUE="mystified-catcher"

LS_BROKER_URI="redis://docker-secx:6379"
LS_BROKER_QUEUE="logstash-ingest"

NAME="tc-catcher"

MONGO_HOST="docker-secx"
MONGO_PORT=27017
#  mongodb://[username:password@]host1[:port1][,host2[:port2],...[,hostN[:portN]]][/[database][?options]]
MONGO_URI="mongodb://$MONGO_HOST:$MONGO_PORT"


MSG_LIMIT=100

# contains hardcoded host names -> IP address
# this needs to have the following:
#
# SYSLOGSERVER_IP SYSLOGSERVER_NAME
KNOWN_HOSTS="./myhosts.txt"

# TODO uncomment below if you want to save to Mongo
#echo "python main.py -msave -mhost $MONGO_HOST -mport $MONGO_PORT \
#      -sport $SYSLOG_LISTEN_PORT -known_hosts hosts.txt \
#      -lhost $ETL_HOST -lport $ETL_PORT" > python_cmd.sh

# TODO comment below if you want to save to Mongo
echo "python main.py -muri $MONGO_URI \
      -broker_uri $BROKER_URI -broker_queue $BROKER_QUEUE \
      -known_hosts $KNOWN_HOSTS -msg_limit $MSG_LIMIT \
      -buffer_uri $LS_BROKER_URI -buffer_queue $LS_BROKER_QUEUE \
      -name $NAME" > python_cmd.sh

cat python_cmd.sh


docker build --no-cache -t $DOCKER_TAG .

# clean up here
rm python_cmd.sh main.py

# run command not 
echo "docker run $DOCKER_PORTS $DOCKER_VOL -it $DOCKER_ENV \
           --name $DOCKER_NAME $DOCKER_TAG"
docker run $DOCKER_PORTS $DOCKER_VOL -it $DOCKER_ENV \
           --name $DOCKER_NAME $DOCKER_TAG

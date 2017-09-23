DOCKER_TAG=python27:latest
DOCKER_NAME=mystified-catcher

# setup dirs
DOCKER_BASE=/data
DOCKER_NB=$DOCKER_BASE/$DOCKER_NAME
DOCKER_LOGS=$DOCKER_NB/logs
DOCKER_DATA=$DOCKER_NB/data

EXPOSED_SYSLOG_PORT=6000
SYSLOG_PORT='6000/udp'
DOCKER_SYSLOG_PORT=$EXPOSED_SYSLOG_PORT:$SYSLOG_PORT
DOCKER_PORTS="-p $DOCKER_SYSLOG_PORT"
DOCKER_ENV=""
DOCKER_VOL=""

sudo mkdir -p $DOCKER_DATA
sudo mkdir -p $DOCKER_LOGS
sudo chmod -R a+rw $DOCKER_NB

# clone the syslog-etl project
git clone https://github.com/deeso/mystified-catcher.git tmp-mystified-catcher
cp tmp-mystified-catcher/main.py .
rm -rf tmp-mystified-catcher


# python script variables
# ****** Important to update the files with the appropriate parameters!!
BROKER_URI="redis://docker-secx:6379"
BROKER_QUEUE="mystified-catcher"

NAME="tc-catcher"

SYSLOG_LISTEN_PORT=$EXPOSED_SYSLOG_PORT

# contains hardcoded host names -> IP address
# this needs to have the following:
#
# SYSLOGSERVER_IP SYSLOGSERVER_NAME
KNOWN_HOSTS="/research_data/myhosts.txt"

# TODO uncomment below if you want to save to Mongo
#echo "python main.py -msave -mhost $MONGO_HOST -mport $MONGO_PORT \
#      -sport $SYSLOG_LISTEN_PORT -known_hosts hosts.txt \
#      -lhost $ETL_HOST -lport $ETL_PORT" > python_cmd.sh

# TODO comment below if you want to save to Mongo
echo "python main.py -name $NAME \
      -sport $SYSLOG_LISTEN_PORT \
      -broker_uri $BROKER_URI -broker_queue $BROKER_QUEUE" > python_cmd.sh

cat python_cmd.sh


docker build --no-cache -t $DOCKER_TAG .

# clean up here
rm python_cmd.sh main.py

# run command not 
echo "docker run $DOCKER_PORTS $DOCKER_VOL -it $DOCKER_ENV \
           --name $DOCKER_NAME $DOCKER_TAG"
docker run $DOCKER_PORTS $DOCKER_VOL -it $DOCKER_ENV \
           --name $DOCKER_NAME $DOCKER_TAG

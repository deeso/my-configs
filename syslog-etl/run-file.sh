DOCKER_TAG=python27:latest
DOCKER_NAME=syslog-etl

# setup dirs
DOCKER_BASE=/data
DOCKER_NB=$DOCKER_BASE/$DOCKER_NAME
DOCKER_LOGS=$DOCKER_NB/logs
DOCKER_DATA=$DOCKER_NB/data

EXPOSED_SYSLOG_PORT=5000
SYSLOG_PORT='5000/udp'
DOCKER_SYSLOG_PORT=$EXPOSED_SYSLOG_PORT:$SYSLOG_PORT
DOCKER_PORTS="-p $DOCKER_SYSLOG_PORT"
DOCKER_ENV=""
DOCKER_VOL=""

sudo mkdir -p $DOCKER_DATA
sudo mkdir -p $DOCKER_LOGS
sudo chmod -R a+rw $DOCKER_NB

# clone the syslog-etl project
git clone https://github.com/deeso/syslog-etl.git tmp-syslog-etl
cp tmp-syslog-etl/main.py .
rm -rf tmp-syslog-etl


# python script variables
# ****** Important to update the files with the appropriate parameters!!
MONGO_HOST="docker-secx"
MONGO_PORT=27017

SYSLOG_LISTEN_PORT=$EXPOSED_SYSLOG_PORT

ETL_HOST="docker-secx"
ETL_PORT=5002

# contains hardcoded host names -> IP address
KNOWN_HOSTS="hosts.txt"

# TODO uncomment below if you want to save to Mongo
#echo "python main.py -msave -mhost $MONGO_HOST -mport $MONGO_PORT \
#      -sport $SYSLOG_LISTEN_PORT -known_hosts hosts.txt \
#      -lhost $ETL_HOST -lport $ETL_PORT" > python_cmd.sh

# TODO comment below if you want to save to Mongo
echo "python main.py -mhost $MONGO_HOST -mport $MONGO_PORT \
      -sport $SYSLOG_LISTEN_PORT -known_hosts hosts.txt \
      -lhost $ETL_HOST -lport $ETL_PORT" > python_cmd.sh

cat python_cmd.sh


docker build --no-cache -t $DOCKER_TAG .

# clean up here
rm python_cmd.sh main.py

# run command not 
echo "docker run $DOCKER_PORTS $DOCKER_VOL -it  $DOCKER_ENV \
           --name $DOCKER_NAME $DOCKER_TAG"
#docker run $DOCKER_PORTS $DOCKER_VOL -it  $DOCKER_ENV \
#           --name $DOCKER_NAME $DOCKER_TAG

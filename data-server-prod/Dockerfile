from sebp/elk:latest

# if debugging uncomment next two commands
#ADD ./logstash-init-debug /etc/init.d/logstash
#RUN sed -i -e 's#^LS_HOME=$#LS_HOME='$LOGSTASH_HOME'#' /etc/init.d/logstash \
# && chmod +x /etc/init.d/logstash

# if debug, uncomment next lin and copy over the debug json file
#ADD ./10-json.conf-debug /etc/logstash/conf.d/10-json.conf
# else copy over the json file
ADD ./10-json.conf /etc/logstash/conf.d/10-json.conf

# remove the syslog conf
RUN rm /etc/logstash/conf.d/10-syslog.conf
#RUN rm /etc/logstash/conf.d/11-nginx.conf

VOLUME ["/var/lib/elasticsearch", "/var/log/logstash/"]

# expose port 5002 for JSON messages
EXPOSE 5601 9200 9300 5044 5002

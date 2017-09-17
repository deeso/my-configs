FROM python:2
ADD python_cmd.sh python_cmd.sh
ADD hosts.txt hosts.txt
ADD main.py main.py

RUN pip install git+https://github.com/deeso/rule_chains.git
RUN pip install git+https://github.com/deeso/syslog-etl.git

CMD [ "sh", "python_cmd.sh" ]

# these may need to be updated if the run-file.sh is changed
EXPOSE 27017 5000 5002


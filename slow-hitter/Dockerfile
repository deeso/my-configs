FROM python:2
ADD python_cmd.sh python_cmd.sh
ADD the_hosts.txt hosts.txt
ADD main.py main.py

RUN pip install git+https://github.com/deeso/rule_chains.git
RUN pip install git+https://github.com/deeso/slow-hitter.git

CMD [ "sh", "python_cmd.sh" ]



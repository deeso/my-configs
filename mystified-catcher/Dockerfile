FROM python:2
ADD python_cmd.sh python_cmd.sh
ADD hosts.txt hosts.txt
ADD main.py main.py

RUN pip install git+https://github.com/deeso/mystified-catcher.git

CMD [ "sh", "python_cmd.sh" ]


FROM python:2
ADD python_cmd.sh python_cmd.sh
ADD main.py main.py

RUN pip install git+https://github.com/deeso/zippy-plop.git

CMD [ "sh", "python_cmd.sh" ]



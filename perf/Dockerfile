FROM python:3.11

ADD requirements.txt .
RUN pip install -r requirements.txt

WORKDIR /demo

COPY ./aioquic/examples ./examples
COPY ./CA/aioquic-server.crt ./certs/
COPY ./CA/aioquic-server.key ./certs/
COPY ./CA/perf-ca.crt ./certs/


RUN echo -n '#!/bin/bash\npython examples/http3_client.py --ca-certs certs/perf-ca.crt https://aioquic-server:443/\n' > client.sh
RUN chmod +x ./client.sh

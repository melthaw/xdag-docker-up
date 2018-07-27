##################################
# How to build the image?
#
# $> docker build -f Dockerfile -t melthaw/xdag-scripts:latest .
#
##################################
FROM ubuntu:xenial

LABEL maintainer "melthaw@gmail.com"

RUN apt-get update && apt-get install -y unzip git gcc libssl-dev libgmp-dev automake autoconf libtool make

RUN useradd --create-home --no-log-init --shell /bin/bash pool

ADD openxdagpool-scripts-master.zip /home/pool
ADD xdag-master.zip /home/pool

RUN su pool && \
    cd /home/pool && \
    echo -n 1 > ~/CURRENT_XDAG && \
    unzip ./openxdagpool-scripts-master.zip && \
    unzip ./xdag-master.zip && \
    mv /home/pool/openxdagpool-scripts-master /home/pool/scripts && \
    cd /home/pool/scripts && \
    mv /home/pool/xdag-master /home/pool/xdag && \
    cd /home/pool/xdag && \
    cd client && make && \
    cp -fr /home/pool/scripts/templates/ /home/pool/xdag/client/

//TODO

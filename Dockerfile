########## How To Use Docker Image ###############
##
##  Image Name: poohsen/monitor-docker:latest
##  Git link: https://github.com/DennyZhang/monitor-docker/blob/master/Dockerfile
##  Docker hub link:
##  Build docker image: docker build --no-cache -t poohsen/monitor-docker:latest --rm=true .
##  How to use:
##      https://github.com/poohsen/monitor-docker/blob/main/README.md
##
##  Description: Send alerts if any containers run into unhealthy
##
##################################################
# Base Docker image: https://hub.docker.com/_/python/

FROM python:3.6.2-jessie

ENV IFTTT_EVENT_NAME ""
ENV IFTTT_SERVICE_KEY ""

ENV MSG_PREFIX ""
ENV WHITE_LIST ""
# seconds
ENV CHECK_INTERVAL "300"


USER root
WORKDIR /
ADD monitor-docker.py /monitor-docker.py
ADD ifttt.py /ifttt.py
ADD monitor-docker.sh /monitor-docker.sh

RUN chmod o+x /*.sh && chmod o+x /*.py && \
    pip install -r requirements.txt && \
# Verify docker image
    pip show requests-unixsocket | grep "0.1.5" 

ENTRYPOINT ["/monitor-docker.sh"]

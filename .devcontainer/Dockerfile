FROM ubuntu:18.04

COPY setup /setup

RUN bash /setup/install.bash

WORKDIR /home/dev/node-postgres-react-app

USER dev

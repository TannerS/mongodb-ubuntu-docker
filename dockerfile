FROM ubuntu:xenial

MAINTAINER Tanner Summers <tannersummers@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

WORKDIR /Mongo

ADD . /Mongo

RUN apt-get update -qq \
&& apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2930ADAE8CAF5059EE73BB4B58712A2291FA4AD5 \
&& echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.6 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-3.6.list \
&& apt-get install -y -qq apt-transport-https \
&& apt-get update -y -qq \
&& apt-get install -y -qq mongodb-org \
&& mkdir -p /data/db \
# https://stackoverflow.com/questions/43817024/how-to-disable-the-mongo-dbshell-history-file
&& echo "" > ~/.dbshell \
&& chmod 0 ~/.dbshell

CMD mongod

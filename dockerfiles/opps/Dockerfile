FROM debian:wheezy

MAINTAINER Guilherme Rezende <guilhermebr@gmail.com>

RUN apt-get update
RUN apt-get install -y build-essential
RUN apt-get install -y python python-dev python-setuptools
RUN easy_install pip

RUN pip install opps


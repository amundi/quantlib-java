FROM ubuntu:22.04

RUN apt-get update

RUN DEBIAN_FRONTEND=noninteractive apt-get install -yq \
    build-essential \
    autoconf \
    swig \
    openjdk-8-jdk-headless
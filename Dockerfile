FROM ubuntu:22.04

ARG QUANTLIB_VERSION=1.29

RUN apt-get update

RUN DEBIAN_FRONTEND=noninteractive apt-get install -yq \
    build-essential \
    autoconf \
    swig \
    openjdk-8-jdk-headless \
    wget \
    libboost-dev 

WORKDIR /root

RUN wget https://github.com/lballabio/QuantLib/releases/download/QuantLib-v${QUANTLIB_VERSION}/QuantLib-${QUANTLIB_VERSION}.tar.gz
RUN wget https://github.com/lballabio/QuantLib-SWIG/releases/download/QuantLib-SWIG-v${QUANTLIB_VERSION}/QuantLib-SWIG-${QUANTLIB_VERSION}.tar.gz

RUN tar -xzf QuantLib-${QUANTLIB_VERSION}.tar.gz && \
    cd QuantLib-${QUANTLIB_VERSION} && \
    ./configure && \
    make && \
    make install

RUN tar -xzf QuantLib-SWIG-${QUANTLIB_VERSION}.tar.gz \
    && cd QuantLib-SWIG-${QUANTLIB_VERSION} \
    && ./configure \ 
        --with-jdk-include=/usr/lib/jvm/java-8-openjdk-arm64/include \ 
        --with-jdk-system-include=/usr/lib/jvm/java-8-openjdk-arm64/include/linux \
    && make -C Java \
    && make install
FROM ubuntu:20.10
ARG PD_VERSION=0.51-3
ARG PD_TARBALL=pd-$PD_VERSION.src.tar.gz
ARG PD_FOLDER=pd-$PD_VERSION

RUN apt update && \
    apt install --no-install-recommends -y \
    wget dh-autoreconf libasound2-dev && \
    apt clean && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir -p /usr/share/man/man1

WORKDIR /tmp
RUN wget http://msp.ucsd.edu/Software/$PD_TARBALL && \
    tar xzvf $PD_TARBALL && \
    cd $PD_FOLDER && \
    ./autogen.sh && \
    ./configure && \
    make && \
    make install

ADD app /app
WORKDIR /app
ENTRYPOINT ["/usr/local/bin/puredata", "-nogui", "netty-mcserver.pd" ]

FROM ubuntu:20.10

ADD app /app
RUN apt update && \
    apt install --no-install-recommends -y puredata && \
    apt clean && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir -p /usr/share/man/man1
WORKDIR /app
ENTRYPOINT ["puredata", "-nogui", "netty-mcserver.pd" ]

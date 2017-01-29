# Dockerfile for https://github.com/adnanh/webhook
# Credit: Almir Dzinovic <almirdzin@gmail.com>

FROM        resin/raspberrypi-golang:1.6

MAINTAINER  Zsolt Balog <zsolt.balog@gmail.com>

ENV         GOPATH /go
ENV         SRCPATH ${GOPATH}/src/github.com/adnanh
ENV         WEBHOOK_VERSION 2.6.0
WORKDIR     /

RUN         apt-get install curl git libc-dev gcc libgcc1
RUN            curl -L -o /tmp/webhook-${WEBHOOK_VERSION}.tar.gz https://github.com/adnanh/webhook/archive/${WEBHOOK_VERSION}.tar.gz
RUN            mkdir -p ${SRCPATH} && tar -xvzf /tmp/webhook-${WEBHOOK_VERSION}.tar.gz -C ${SRCPATH}
RUN            mv -f ${SRCPATH}/webhook-* ${SRCPATH}/webhook
RUN            cd ${SRCPATH}/webhook && go get -d && go build -o /usr/local/bin/webhook

EXPOSE      9000

ENTRYPOINT  ["/usr/local/bin/webhook"]

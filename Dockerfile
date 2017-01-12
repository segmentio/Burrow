FROM golang:alpine

MAINTAINER LinkedIn Burrow "https://github.com/segmentio/Burrow"

RUN apk add --update ca-certificates \
  && update-ca-certificates \
  && rm -rf /var/cache/apk/*

ADD . $GOPATH/src/github.com/segmentio/Burrow
RUN cd $GOPATH/src/github.com/segmentio/Burrow \
  && go install \
  && mv /go/bin/Burrow /go/bin/burrow

ADD docker-config /etc/burrow
WORKDIR /var/tmp/burrow
ENTRYPOINT ["/go/bin/burrow"]
CMD ["--config", "/etc/burrow/burrow.cfg"]

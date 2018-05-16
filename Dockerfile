FROM golang:alpine

RUN apk add --update ca-certificates \
  && update-ca-certificates \
  && rm -rf /var/cache/apk/*

ADD . $GOPATH/src/github.com/segmentio/burrow
RUN cd $GOPATH/src/github.com/segmentio/burrow \
  && go install \
  && test -f /go/bin/burrow

ADD docker-config /etc/burrow
WORKDIR /var/tmp/burrow
ENTRYPOINT ["/go/bin/burrow"]
CMD ["--config", "/etc/burrow/burrow.cfg"]

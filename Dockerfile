FROM golang:alpine

MAINTAINER LinkedIn Burrow "https://github.com/linkedin/Burrow"

RUN apk add --update bash curl git && apk add ca-certificates wget && update-ca-certificates && rm -rf /var/cache/apk/*

ADD . $GOPATH/src/github.com/linkedin/burrow
RUN cd $GOPATH/src/github.com/linkedin/burrow && go install

ADD docker-config /etc/burrow

WORKDIR /var/tmp/burrow

CMD ["/go/bin/burrow", "--config", "/etc/burrow/burrow.cfg"]

FROM golang:1.9.2 as builder

RUN mkdir -p /go/src/github.com/peterj/semver
WORKDIR  /go/src/github.com/peterj/semver

RUN go get -u github.com/golang/dep/cmd/dep 
COPY . .
RUN dep ensure -v
RUN make build

FROM alpine:latest
RUN apk --no-cache add ca-certificates
WORKDIR /root/
RUN mkdir -p public
COPY --from=builder /go/src/github.com/peterj/semver/semver .
COPY --from=builder /go/src/github.com/peterj/semver/public public

ENTRYPOINT [ "./semver" ]
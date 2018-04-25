FROM golang:1.10-alpine as builder
ADD . /go/src/github.com/src-d/rovers
RUN go install github.com/src-d/rovers

FROM alpine:3.7
MAINTAINER source{d}
RUN apk add --no-cache ca-certificates
COPY --from=builder /go/bin/rovers /bin/
CMD ["rovers","repos"]

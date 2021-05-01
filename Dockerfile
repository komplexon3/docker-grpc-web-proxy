FROM golang:1.16-alpine as builder
LABEL maintainer="komplexon3@protonmail.com"

RUN apk update && apk upgrade

RUN go get -u github.com/improbable-eng/grpc-web/go/grpcwebproxy


FROM alpine:latest
LABEL maintainer="komplexon3@protonmail.com"

COPY --from=builder /go/bin/grpcwebproxy .

CMD [ "sh", "-c", \
    "./grpcwebproxy --backend_addr=$BACKENDADDR --run_tls_server=false --allow_all_origins"]

# we need a newer version of rclone, so build from source
FROM golang:1.17.6-buster as rclone_builder

RUN \
  cd /go/src \
  && git clone https://github.com/rclone/rclone.git \
  && cd rclone \
  && git checkout v1.57.0 \
  && go build \
  && make install

FROM debian:buster-slim

COPY --from=rclone_builder /usr/bin/rclone /usr/bin

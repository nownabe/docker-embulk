FROM alpine:3.8

RUN apk --no-cache update \
  && apk --no-cache add \
    openjdk8-jre-base=8.191.12-r0 \
    libc6-compat=1.1.19-r10 \
  && addgroup -g 61000 docker \
  && adduser -s /bin/false -G docker -D -u 61000 docker \
  && echo 'export PATH=/home/docker/.embulk/bin:$PATH' > /etc/profile.d/embulk.sh # for `sh -l`

USER docker
WORKDIR /home/docker

RUN mkdir -p /home/docker/.embulk/bin \
  && wget -q -O /home/docker/.embulk/bin/embulk https://dl.embulk.org/embulk-latest.jar \
  && chmod +x /home/docker/.embulk/bin/embulk

ENV PATH /home/docker/.embulk/bin:$PATH

CMD ["/home/docker/.embulk/bin/embulk"]

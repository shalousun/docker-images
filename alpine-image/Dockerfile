# Build with:
# docker build -t alpine-bash:3.11 .
# set timezone Asia/Shanghai

FROM alpine:3.11
ENV TZ="Asia/Shanghai"

RUN \
    echo "http://mirrors.aliyun.com/alpine/v3.11/main" > /etc/apk/repositories && \
    echo "http://mirrors.aliyun.com/alpine/v3.11/community" >> /etc/apk/repositories  && \
    apk update upgrade && \
    apk add --no-cache procps curl bash busybox-extras tzdata iproute2 && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

CMD ["bash"]

FROM blacktop/logstash:7.6

ENV TZ="Asia/Shanghai"

RUN \
    echo "http://mirrors.aliyun.com/alpine/v3.10/main" > /etc/apk/repositories && \
    echo "http://mirrors.aliyun.com/alpine/v3.10/community" >> /etc/apk/repositories  && \
    apk update upgrade && \
    apk add --no-cache procps curl bash busybox-extras tzdata iproute2 && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

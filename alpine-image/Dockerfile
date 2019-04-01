# Build with:
# docker build -t alpine-bash:3.8 .
# set timezone Asia/Shanghai

FROM alpine:3.8
ENV TZ="Asia/Shanghai"

RUN \
    echo "http://mirrors.aliyun.com/alpine/v3.8/main" > /etc/apk/repositories && \
    echo "http://mirrors.aliyun.com/alpine/v3.8/community" >> /etc/apk/repositories  && \
    apk update upgrade && \
    apk add --no-cache tzdata procps curl bash && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

CMD ["bash"]

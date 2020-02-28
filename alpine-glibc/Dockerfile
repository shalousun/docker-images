# Build with:
# docker build -t alpine-glibc:3.11 .
# set timezone Asia/Shanghai

FROM alpine:3.11
ENV TZ="Asia/Shanghai" \
    GLIBC_PACKAGE_VERSION="2.30-r0"

RUN \
    echo "http://mirrors.aliyun.com/alpine/v3.11/main" > /etc/apk/repositories && \
    echo "http://mirrors.aliyun.com/alpine/v3.11/community" >> /etc/apk/repositories  && \
    apk update upgrade && \
    apk --no-cache add ca-certificates && \
    wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://raw.githubusercontent.com/sgerrand/alpine-pkg-glibc/master/sgerrand.rsa.pub && \
    wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_PACKAGE_VERSION}/glibc-${GLIBC_PACKAGE_VERSION}.apk && \
    apk add glibc-${GLIBC_PACKAGE_VERSION}.apk && \
    apk add --no-cache procps curl bash busybox-extras tzdata iproute2 && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

CMD ["bash"]

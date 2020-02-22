FROM registry.cn-shanghai.aliyuncs.com/shalousun/aphine-oraclejdk-arthas:1.0.0

MAINTAINER shalousun

ENV version=1.4.4
ENV KE_HOME=/opt/kafka-eagle
RUN echo "http://mirrors.aliyun.com/alpine/v3.9/main" > /etc/apk/repositories && \
    echo "http://mirrors.aliyun.com/alpine/v3.9/community" >> /etc/apk/repositories  && \
    apk update && \
    apk add sqlite && \
    curl -OL "https://github.com/smartloli/kafka-eagle-bin/archive/v${version}.tar.gz" && \
    tar -xzvf v${version}.tar.gz && \
    tar -xzvf kafka-eagle-bin-${version}/kafka-eagle-web-${version}-bin.tar.gz && \
    mv kafka-eagle-web-${version} /kafka-eagle && \
    rm -rf $v{version}.tar.gz kafka-eagle-bin-${version}
WORKDIR /opt/kafka-eagle

COPY entrypoint.sh ./bin/entrypoint.sh
CMD ["sh", "/opt/kafka-eagle/bin/entrypoint.sh"]

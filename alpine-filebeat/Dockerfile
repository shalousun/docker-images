FROM registry.cn-hangzhou.aliyuncs.com/shalousun/alpine-zh:3.9

MAINTAINER yusun <836575280@qq.com>

ENV FILEBEAT_VERSION=7.6.2

# Install filebeat

RUN apk add --update-cache curl bash libc6-compat && \
    rm -rf /var/cache/apk/* && \
    curl https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-${FILEBEAT_VERSION}-linux-x86_64.tar.gz -o /filebeat.tar.gz && \
    tar xzvf filebeat.tar.gz && \
    rm filebeat.tar.gz && \
    mv filebeat-${FILEBEAT_VERSION}-linux-x86_64 filebeat && \
    cd filebeat && \
    cp filebeat /usr/bin && \
    ls -ltr /filebeat && \
    cat /filebeat/filebeat.yml

VOLUME /filebeat/data

WORKDIR /filebeat/
CMD ["./filebeat","-e","-c", "filebeat.yml"]
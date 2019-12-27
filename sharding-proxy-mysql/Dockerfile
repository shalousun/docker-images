FROM registry.cn-shanghai.aliyuncs.com/shalousun/alpine-oraclejdk8-perf4j:1.0.0

MAINTAINER shalousun

ENV CURRENT_VERSION 4.0.0-RC3
ENV APP_NAME apache-shardingsphere-incubating
ENV MODULE_NAME sharding-proxy
ENV LOCAL_PATH /opt/sharding-proxy

COPY ./sharding-proxy /opt/sharding-proxy
ENTRYPOINT /opt/sharding-proxy/bin/start.sh $PORT && tail -f /opt/sharding-proxy/logs/stdout.log
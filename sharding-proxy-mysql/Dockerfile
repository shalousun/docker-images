FROM registry.cn-shanghai.aliyuncs.com/shalousun/alpine-oraclejdk8-perf4j:1.0.1

MAINTAINER shalousun

ENV CURRENT_VERSION 4.1.1
ENV APP_NAME apache-shardingsphere
ENV MODULE_NAME sharding-proxy
ENV LOCAL_PATH /opt/sharding-proxy

RUN wget https://mirrors.tuna.tsinghua.edu.cn/apache/shardingsphere/${CURRENT_VERSION}/${APP_NAME}-${CURRENT_VERSION}-${MODULE_NAME}-bin.tar.gz && \
    tar -xzvf ${APP_NAME}-${CURRENT_VERSION}-sharding-proxy-bin.tar.gz && \
    tar -xzvf ${APP_NAME}-${CURRENT_VERSION}-${MODULE_NAME}-bin.tar.gz && \
    mv ${APP_NAME}-${CURRENT_VERSION}-${MODULE_NAME}-bin ${LOCAL_PATH} && \
    rm -f ${APP_NAME}-${CURRENT_VERSION}-${MODULE_NAME}-bin.tar.gz

# copy library
COPY lib/* /opt/sharding-proxy/lib/

ENTRYPOINT /opt/sharding-proxy/bin/start.sh $PORT && tail -f /opt/sharding-proxy/logs/stdout.log
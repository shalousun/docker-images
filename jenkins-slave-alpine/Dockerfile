FROM jenkinsci/jnlp-slave:3.35-2-alpine

MAINTAINER 836575280@qq.com

USER root

LABEL Description="This is a extend image base from jenkins/jnlp-slave which install maven in it."
ENV MAVEN_VERSION=3.6.3
ENV MAVEN_HOME=/usr/local/maven
ENV PATH ${MAVEN_HOME}/bin:${PATH}

RUN echo "http://mirrors.aliyun.com/alpine/v3.9/main" > /etc/apk/repositories && \
    echo "http://mirrors.aliyun.com/alpine/v3.19/community" >> /etc/apk/repositories  && \
    apk update upgrade && \
    apk add --no-cache procps curl bash busybox-extras tzdata iproute2 && \
    wget https://mirrors.tuna.tsinghua.edu.cn/apache/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz && \
    tar -xzvf apache-maven-$MAVEN_VERSION-bin.tar.gz && \
    mv apache-maven-$MAVEN_VERSION ${MAVEN_HOME} && \
    rm -rf apache-maven-$MAVEN_VERSION-bin.tar.gz

COPY conf/* $MAVEN_HOME/conf

ENV TZ="Asia/Shanghai"
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

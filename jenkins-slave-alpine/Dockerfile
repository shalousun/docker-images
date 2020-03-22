FROM jenkinsci/jnlp-slave:3.35-2-alpine

MAINTAINER 836575280@qq.com

ARG user=jenkins

USER root

LABEL Description="This is a extend image base from jenkins/jnlp-slave which install maven in it."
ENV KUBECTL_VERSION=v1.17.3
ENV MAVEN_VERSION=3.6.3
ENV MAVEN_HOME=/usr/local/maven
ENV PATH ${MAVEN_HOME}/bin:${PATH}

RUN echo "http://mirrors.aliyun.com/alpine/v3.9/main" > /etc/apk/repositories && \
    echo "http://mirrors.aliyun.com/alpine/v3.9/community" >> /etc/apk/repositories  && \
    apk update upgrade && \
    apk add --no-cache procps shadow sudo curl bash busybox-extras tzdata iproute2 docker && \
    wget https://mirrors.tuna.tsinghua.edu.cn/apache/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz && \
    tar -xzvf apache-maven-$MAVEN_VERSION-bin.tar.gz && \
    mv apache-maven-$MAVEN_VERSION ${MAVEN_HOME} && \
    rm -rf apache-maven-$MAVEN_VERSION-bin.tar.gz && \
    wget https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/kubernetes-client-linux-amd64.tar.gz && \
    tar -xzvf kubernetes-client-linux-amd64.tar.gz && \
    cp kubernetes/client/bin/kubectl /usr/local/bin/ && \
    chmod +x /usr/local/bin/kubectl && \
    rm -rf kubernetes && \
    sudo usermod -aG docker ${user}

COPY conf/* $MAVEN_HOME/conf

ENV TZ="Asia/Shanghai"
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

#USER ${user}

ENTRYPOINT ["jenkins-slave"]
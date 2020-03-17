FROM jenkinsci/jnlp-slave:3.35-2-alpine

ENV MAVEN_VERSION=3.6.3
ENV MAVEN_HOME=/usr/local/maven
ENV PATH ${MAVEN_HOME}/bin:${PATH}

RUN wget https://mirrors.tuna.tsinghua.edu.cn/apache/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz && \
    tar -xzvf apache-maven-$MAVEN_VERSION-bin.tar.gz && \
    mv apache-maven-$MAVEN_VERSION ${MAVEN_HOME} && \
    rm -rf apache-maven-$MAVEN_VERSION-bin.tar.gz

COPY conf/* $MAVEN_HOME/conf


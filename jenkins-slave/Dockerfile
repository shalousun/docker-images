FROM shaloudocker/jenkins-slave-base:latest

ENV MAVEN_VERSION 3.5.3
ENV JAVA_HOME /usr/local/java/jdk8
ENV MAVEN_HOME /opt/maven/apache-maven-${MAVEN_VERSION}
ENV CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
ENV TZ="Asia/Shanghai"
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# build java
COPY ./jdk1.8.0_181 ${JAVA_HOME}
COPY ./libltdl.so.7 /usr/lib/libltdl.so.7

# build maven
COPY apache-maven-${MAVEN_VERSION}-bin.tar.gz /tmp/maven/apache-maven-${MAVEN_VERSION}-bin.tar.gz
COPY settings.xml /tmp/maven/settings.xml
USER root:root
RUN mkdir -p /opt/maven/repository \
    && cd /opt/maven \
    && tar -zxvf /tmp/maven/apache-maven-${MAVEN_VERSION}-bin.tar.gz  \
    && cp /tmp/maven/settings.xml ${MAVEN_HOME}/conf/settings.xml \
    && rm -rf /tmp/maven

ENV PATH ${MAVEN_HOME}/bin:${PATH}

FROM registry.cn-shanghai.aliyuncs.com/shalousun/alpine-oraclejdk8-perf4j:1.0.2

MAINTAINER shalousun
EXPOSE 8080

# install Spring Boot artifact
VOLUME /tmp
ADD soul-admin.jar soul-admin.jar
RUN sh -c 'touch /soul-admin.jar'
# default profiles
ENV PROFILES="container"
# set jvm
ENV JAVA_OPTS="-server -Xmx512m -Xms512m -Djava.awt.headless=true"
ENTRYPOINT [ "sh", "-c", "java $JAVA_OPTS -Djava.security.egd=file:/dev/./urandom -jar /soul-admin.jar" ]
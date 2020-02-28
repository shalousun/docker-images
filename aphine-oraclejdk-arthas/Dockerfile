FROM frolvlad/alpine-glibc:alpine-3.10

MAINTAINER shalousun

ENV JAVA_VERSION=8 \
    JAVA_HOME="/usr/lib/jvm/default-jvm"
# copy arthas
COPY --from=frolvlad/alpine-java /usr/lib/jvm/java-8-oracle /usr/lib/jvm/java-8-oracle
#### START OF TIMEZONE RELATED COMMANDS ####
RUN echo "http://mirrors.aliyun.com/alpine/v3.10/main" > /etc/apk/repositories && \
    echo "http://mirrors.aliyun.com/alpine/v3.10/community" >> /etc/apk/repositories  && \
    apk update upgrade && \
    apk add --no-cache procps curl bash busybox-extras tzdata iproute2 && \
    ln -s "/usr/lib/jvm/java-8-oracle" "$JAVA_HOME" && \
    ln -s "$JAVA_HOME/bin/"* "/usr/bin/" && \
    sed -i -e 's/^root::/root:!:/' /etc/shadow

ENV TZ="Asia/Shanghai"
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

CMD ["bash"]
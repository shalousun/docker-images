FROM frolvlad/alpine-java

MAINTAINER shalousun

# copy arthas
COPY --from=hengyunabc/arthas:latest /opt/arthas /opt/arthas
#### START OF TIMEZONE RELATED COMMANDS ####
RUN echo "http://mirrors.aliyun.com/alpine/v3.9/main" > /etc/apk/repositories && \
    echo "http://mirrors.aliyun.com/alpine/v3.9/community" >> /etc/apk/repositories  && \
    apk update upgrade && \
    apk add --no-cache procps curl bash busybox-extras tzdata iproute2

#sed -i -e 's/^root::/root:!:/' /etc/shadow
ENV TZ="Asia/Shanghai"
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

CMD ["bash"]
FROM frolvlad/alpine-java

MAINTAINER shalousun

COPY ./MyPerf4J /MyPerf4J
#### START OF TIMEZONE RELATED COMMANDS ####
RUN apk update
RUN apk add --no-cache procps curl bash busybox-extras tzdata iproute2
RUN sed -i -e 's/^root::/root:!:/' /etc/shadow
ENV TZ="Asia/Shanghai"
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

CMD ["bash"]
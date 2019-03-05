FROM frolvlad/alpine-oraclejdk8

MAINTAINER shalousun

#### START OF TIMEZONE RELATED COMMANDS ####
RUN apk update
RUN apk add --no-cache procps curl bash
RUN apk add apk add busybox-extras
RUN apk add tzdata
ENV TZ="Asia/Shanghai"
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

CMD ["bash"]
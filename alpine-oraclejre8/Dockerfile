FROM frolvlad/alpine-oraclejre8:slim

MAINTAINER yusun

#### START OF TIMEZONE RELATED COMMANDS ####
RUN apk update
RUN apk add --no-cache procps curl bash
RUN apk add tzdata
ENV TZ="Asia/Shanghai"
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN echo "export LC_ALL=zh_CN.UTF-8"  >>  /etc/profile

CMD ["bash"]
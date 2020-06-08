FROM registry.cn-hangzhou.aliyuncs.com/shalousun/alpine-zh:3.11

MAINTAINER yusun <836575280@qq.com>

ENV KIBANA_VER=7.6.2
RUN apk --update --no-cache add nodejs wget openssl ca-certificates \
&& cd /usr/share \
&& wget https://artifacts.elastic.co/downloads/kibana/kibana-$KIBANA_VER-linux-x86_64.tar.gz -O - | tar xvfz - \
&& mv kibana-$KIBANA_VER-linux-x86_64 kibana \
&& rm -rf kibana/node \
&& apk del openssl ca-certificates \
&& rm  -rf /tmp/* /var/cache/apk/*
RUN chown -R root:root /usr/share/kibana
RUN sed -i "s/:\/bin/:\/bin:\/usr\/share\/kibana\/bin/" /etc/profile
ADD docker-entrypoint.sh /usr/sbin
EXPOSE 5601
ENTRYPOINT ["sh","/usr/sbin/docker-entrypoint.sh"]
CMD ["kibana"]



FROM registry.cn-hangzhou.aliyuncs.com/shalousun/alpine-zh:3.8

MAINTAINER yusun <836575280@qq.com>

ENV KIBANA_VERSION=5.2.1 \
    APP_HOME=/usr/local/kibana
# Install filebeat

RUN apk add --update-cache curl wget bash libc6-compat nodejs && \
    rm -rf /var/cache/apk/* && \
    wget -q -O /tmp/kibana.tar.gz https://artifacts.elastic.co/downloads/kibana/kibana-${KIBANA_VERSION}-linux-x86_64.tar.gz && \
    tar -xzf /tmp/kibana.tar.gz -C /usr/local && \
    ln -sf /usr/local/kibana-${KIBANA_VERSION}-linux-x86_64 ${APP_HOME} && \
    mkdir -p /var/log/kibana /etc/kibana && \
    rm -rf /tmp/kibana.tar.gz


#RUN	/usr/local/kibana/bin/kibana-plugin install x-pack

COPY ./config/kibana.yml /etc/kibana/kibana.yml
ADD scripts /usr/local/kibana/
RUN chown -R root:root /usr/local/kibana-${KIBANA_VERSION}-linux-x86_64 /var/log/kibana /etc/kibana
ENTRYPOINT ["sh","/usr/local/kibana/kibana.sh"]


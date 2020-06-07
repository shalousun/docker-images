FROM docker.elastic.co/elasticsearch/elasticsearch:7.6.2

MAINTAINER shalousun <836575280@qq.com>

ENV CURRENT_VERSION=1.6.0.0

RUN yum -y install wget && \
    wget -P /usr/share/ https://d3g5vo6xdbdb9a.cloudfront.net/downloads/elasticsearch-plugins/opendistro-sql/opendistro_sql-${CURRENT_VERSION}.zip && \
    /usr/share/elasticsearch/bin/elasticsearch-plugin install file:///usr/share/opendistro_sql-${CURRENT_VERSION}.zip && \
    rm -rf /usr/share/opendistro_sql-${CURRENT_VERSION}.zip && \
    echo 'http.cors.enabled: true' >> /usr/share/elasticsearch/config/elasticsearch.yml && \
    echo 'http.cors.allow-origin: "*"' >> /usr/share/elasticsearch/config/elasticsearch.yml
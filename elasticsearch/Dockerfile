FROM docker.elastic.co/elasticsearch/elasticsearch:7.4.2

MAINTAINER smart-doc <836575280@qq.com>
RUN yum -y install wget && \
    wget -P /usr/share/ https://d3g5vo6xdbdb9a.cloudfront.net/downloads/elasticsearch-plugins/opendistro-sql/opendistro_sql-1.4.0.0.zip && \
    /usr/share/elasticsearch/bin/elasticsearch-plugin install file:///usr/share/opendistro_sql-1.4.0.0.zip && \
    rm -rf /usr/share/opendistro_sql-1.4.0.0.zip && \
    echo 'http.cors.enabled: true' >> /usr/share/elasticsearch/config/elasticsearch.yml && \
    echo 'http.cors.allow-origin: "*"' >> /usr/share/elasticsearch/config/elasticsearch.yml
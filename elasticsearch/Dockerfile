FROM docker.elastic.co/elasticsearch/elasticsearch:7.4.2

MAINTAINER smart-doc <836575280@qq.com>
RUN yum -y install wget \
    wget https://d3g5vo6xdbdb9a.cloudfront.net/downloads/elasticsearch-plugins/opendistro-sql/opendistro_sql-1.4.0.0.zip
RUN /usr/share/elasticsearch/bin/elasticsearch-plugin install file:///opendistro_sql-1.4.0.0.zip
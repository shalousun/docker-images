FROM jenkinsci/jnlp-slave:latest

MAINTAINER shalousun
USER root:root
RUN apt-get -yq update  \
    && apt-get -yq --no-install-recommends --no-install-suggests install sshpass \
    && apt-get clean -y



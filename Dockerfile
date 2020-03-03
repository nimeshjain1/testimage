#FROM registry.access.redhat.com/ubi7/nodejs-8
FROM centos/nodejs-8-centos7 

MAINTAINER "maintainer@dsop.io"

LABEL name="nodejs8"
LABEL version="8.11.4"

USER 0
RUN curl https://dccscr.dsop.io/dsop/ubi7/raw/minimal/dsop-fix.sh | sh
USER 1001

ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

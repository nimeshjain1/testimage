#ARG BASE_REGISTRY=registry.access.redhat.com
#ARG BASE_IMAGE=ubi7
#ARG BASE_TAG=7.7
#pFROM $BASE_REGISTRY/$BASE_IMAGE:$BASE_TAG
FROM registry.access.redhat.com/ubi7:7.7


MAINTAINER "maintainer@dsop.io"

LABEL io.k8s.description="Redis is an open source, in-memory data structure store, used as database, cache and message broker." \
      io.k8s.display-name="Redis 4.0.14" \
      io.openshift.expose-services="6379:redis" \
      io.openshift.tags="database,redis,redis4"

LABEL Name="redis-40-ubi7" \
      Version="4.0.14" \
      Architecture="x86_64"

RUN yum -y --nogpgcheck --setopt=tsflags=nodocs --disableplugin=subscription-manager update && \
    curl -fvksSL "https://nexus.52.61.140.4.nip.io/repository/cht/r/3.5.2/epel-release-7-11.noarch.rpm" --output /tmp/epel-release-7-11.noarch.rpm && \
    rpm -Uvh --oldpackage /tmp/epel-release-7-11.noarch.rpm && \
    yum -y --nogpgcheck --setopt=tsflags=nodocs --disableplugin=subscription-manager install redis && \
    yum clean all

COPY redis-master.conf /redis-master/redis.conf
COPY redis-slave.conf /redis-slave/redis.conf
COPY entrypoint /entrypoint
RUN mkdir /redis-master-data && \
    chmod 755 /entrypoint /redis-master-data && \
    chown 997 /redis-master-data

EXPOSE 6379

# By default will run as random user on openshift and the redis user (997)
# everywhere else
USER 997

CMD [ "/entrypoint" ]
ENTRYPOINT [ "sh", "-c" ]

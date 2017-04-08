FROM ruby:2.3.3-alpine
MAINTAINER Patricio Pérez <pperez@boaboa.org>

ENV BACKUP_VERSION 4.4.0
ENV WHENEVER_VERSION 0.9.7

RUN apk update \
  && apk add build-base redis mysql postgresql openssh-client tar rsync \
  && gem install backup -v $BACKUP_VERSION \
  && gem install whenever -v $WHENEVER_VERSION

COPY docker-entrypoint.sh /usr/local/bin/
RUN ln -s usr/local/bin/docker-entrypoint.sh /entrypoint.sh # backwards compat
ENTRYPOINT ["docker-entrypoint.sh"]

VOLUME ["/root/Backup"]
WORKDIR "/root/Backup"

CMD ["crond", "-f"]

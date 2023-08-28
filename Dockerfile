FROM bcit.io/alpine:3.18

LABEL maintainer="jesse@weisner.ca"
LABEL build_id="1693185461"

RUN apk upgrade --no-cache \
 && apk add --no-cache \
        keepalived

RUN mkdir -p /etc/keepalived

ENV KEEPALIVED_CHECK_SCRIPT=/bin/true
ENV KEEPALIVED_CHECK_SCRIPT_INTERVAL=5
ENV KEEPALIVED_CHECK_SCRIPT_WEIGHT=99
ENV KEEPALIVED_SCRIPT_USER=nobody
ENV KEEPALIVED_SERVICE_NAME=vip
ENV KEEPALIVED_INITIAL_STATE=
ENV KEEPALIVED_ROUTER_ID=1
ENV KEEPALIVED_PRIORITY=
ENV KEEPALIVED_NOPREEMPT=
ENV KEEPALIVED_AUTH_PASS=changeme
ENV KEEPALIVED_INTERFACE=
ENV KEEPALIVED_TRACK_INTERFACES=
ENV KEEPALIVED_UNICAST_SRC_IP=
ENV KEEPALIVED_UNICAST_PEERS=169.254.0.2
ENV KEEPALIVED_VIRTUAL_IPADDRESSES=169.254.0.1

ADD 050-get-ip.sh /docker-entrypoint.d/050-get-ip.sh
ADD 999-template-keepalived.sh /docker-entrypoint.d/999-template-keepalived.sh
ADD keepalived.conf.tmpl /etc/keepalived.conf.tmpl

ENTRYPOINT ["/tini", "--", "/docker-entrypoint.sh"]
CMD [ "/usr/sbin/keepalived", "-f", "/etc/keepalived/keepalived.conf", "--dont-fork", "--log-console" ]

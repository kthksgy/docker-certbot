FROM alpine:3.11

ARG CRON_SCHEDULE="25 5 * * 3"

RUN apk --no-cache --virtual .tmp add tzdata && \
    cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime && \
    apk del .tmp

RUN apk --no-cache add certbot && \
    echo "${CRON_SCHEDULE} certbot renew" >> /var/spool/cron/crontabs/root

ENTRYPOINT [ "crond", "-f" ]
CMD [ "-l", "2" ]
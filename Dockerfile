# Postfix con Base Alpine
FROM alpine:latest

# Instalando postfix
RUN apk add --update bash busybox-extras rsyslog supervisor && rm -rf /var/cache/apk/*


# Alpine comes with built in cron schedules
# min   hour    day     month   weekday command
# */15    *       *       *       *       run-parts /etc/periodic/15min
# 0       *       *       *       *       run-parts /etc/periodic/hourly
# 0       2       *       *       *       run-parts /etc/periodic/daily
# 0       3       *       *       6       run-parts /etc/periodic/weekly
# 0       5       1       *       *       run-parts /etc/periodic/monthly

# adicionando la carpeta de las backup
COPY ./periodic/ /etc/

# Creando los volumenes
VOLUME ["/var/log/"]

RUN mkdir -p /var/log/supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
CMD ["sh","-c","/usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf"]

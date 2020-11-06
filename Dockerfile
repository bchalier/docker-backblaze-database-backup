FROM alpine

RUN apk add --no-cache mariadb-client mariadb-connector-c bash python3 py3-pip openssl && \
    rm -rf /var/cache/apk/* && \
    pip3 install b2

COPY . /backup

RUN chmod +x /backup/backup.sh

WORKDIR /backup

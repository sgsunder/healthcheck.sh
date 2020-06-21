#!/bin/sh
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

mkdir -p /usr/local/sbin/

cd "$(dirname "$0")"

cp ./healthcheck-httpd.sh /usr/local/sbin/healthcheck-httpd
cp ./openrc.service /etc/init.d/heathcheck-httpd

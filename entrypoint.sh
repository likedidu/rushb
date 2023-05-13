#!/bin/bash

mkdir /wwwroot

mv /v2-server /usr/bin/v2-server

if [ ! -d /etc/server ]; then  
  mkdir /etc/server
fi

sed -e "/^#/d"\
    -e "s|\${PASSWORD}|${PASSWORD}|g"\
    -e "s|\${SERVER_PATH}|${SERVER_PATH}|g"\
    /conf/server-config.json >  /etc/server/config.json

echo /etc/server/config.json

cat /etc/server/config.json

sed -e "/^#/d"\
    -e "s/\${PORT}/${PORT}/g"\
    -e "s|\${SERVER_PATH}|${SERVER_PATH}|g"\
    -e "$s"\
    /conf/nginx.conf > /etc/nginx/conf.d/ss.conf 

cat /etc/nginx/conf.d/ss.conf 

v2-server run -c /etc/server/config.json &

rm -rf /etc/nginx/sites-enabled/default
nginx -g 'daemon off;'

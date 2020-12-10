#!/bin/bash

sed -i 's/{PROXY_HOST}/'$PROXY_HOST'/g' /usr/local/tomcat/webapps/ROOT/print-apps/oereb/config.yaml
sed -i 's/{PROXY_PORT}/'$PROXY_PORT'/g' /usr/local/tomcat/webapps/ROOT/print-apps/oereb/config.yaml

/usr/local/tomcat/bin/docker-start-print
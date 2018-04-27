#!/bin/bash

sed -i "s|^socket=.*$|socket=unix://${RUN_DIR}/fcgiwrap.sock|"         /etc/supervisord.conf/fcgiwrap.ini
sed -i "s|^\s*server\s+.*$|    server unix:${RUN_DIR}/fcgiwrap.sock;|" /etc/nginx/conf.d/fcgi.upstream

crf.fixupDirectory "$RUN_DIR"

#!/bin/bash

sed -i "s|^listen\s*=.*$|listen=${RUN_DIR}/php-fpm.sock|"              /etc/php7/conf.d/php-fpm.conf
sed -i "s|^\s*server\s+.*$|    server unix:${RUN_DIR}/php-fpm.sock;|"  /etc/nginx/conf.d/php_fpm.upstream

declare iniFile=/etc/php7/php.ini
sed -i -e "s|^.*date.timezone\s*=.*$|date.timezone = ${TZ}|" \
       -e "s|^.*session.save_path\s*=.*$|session.save_path = \"${SESSIONS_DIR}\"|" \
       -e "s|^.*open_basedir\s*=.*$|open_basedir = ${WWW}|" "$iniFile"
       
declare cnfFile=/etc/php7/conf.d/php-fpm.conf
sed -i -e "s|^.*chdir\s*=.*$|chdir = ${WWW}|" "$cnfFile" 

crf.fixupDirectory "$RUN_DIR"
crf.fixupDirectory "$SESSIONS_DIR"

chown "${www['user']}":"${www['group']}" -R "$SESSIONS_DIR"
chown "${www['user']}":"${www['group']}" -R "$RUN_DIR"

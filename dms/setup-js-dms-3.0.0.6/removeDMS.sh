#!/bin/sh
service jusondms stop
service jsmysql stop
sleep 2
cd /juson_file
rm -rf /jsdata/mysql8
rm -rf /var/log/zx_dms
rm -rf /juson_file/*
systemctl disable jusondms.service
systemctl disable jsmysql.service
ps -ef|grep mysql| grep jsdata| awk '{print $2}'|xargs kill -9




#!/bin/bash

#获得当前的时间
ctime=$(date +%Y%m%d%H%M%S)

#备份/var/log目录
tar czf /backup/log_${ctime}.tar.gz /var/log

#删除7天前的备份文件
find /backup -mtime +7 -type f -name "*.tar.gz" -exec rm -rf {} \;

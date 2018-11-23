#!/bin/bash
#vicent.guo
#20180815

#Defining variable
dt=$(date +%Y%m%d)
dirname=($(find /data -maxdepth 1  \( -path "/data/lost+found" -o -path "/data/tools"  -o -path "/data/backup" -o -path "/data/game_html" -o -path "/data/nginx_logs"  -o -path "/data/sports_jj" -o -path "/data/temp" -o -path "/data/sports_html" -o -path "/data/app_html" -o -path "/data/tools" -o -path "/data/ybf-cg" \) -prune -o  -type d -print | awk -F"/" '{print $3}' |awk 'NF'))

num=${#dirname[@]}
for ((i=0;i<$num;i++))
do
  rsync -vzrtopg --delete --exclude="logs" --exclude="log" --exclude="work" --exclude="soft" --exclude="tp" --exclude="js/analysis" --exclude="js/data" --exclude="js/eventsSearch" --exclude="js/homePage" --exclude="js/scoreBoard" --exclude="js/team" /data/${dirname[i]}/ /data/backup/${dirname[i]}-$dt
done

#delete data from /home/hhlyadmin/server-bak/ 7 days ago
find /data/backup/* -maxdepth 0 |egrep *-`date -d "3 days ago" "+%Y%m%d"` |xargs rm -rf


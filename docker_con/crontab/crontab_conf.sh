#!/bin/bash
set -e
echo "Inicia la creación del crontab!"    
date="$(date '+%d/%m/%Y-%T')"
echo $date >> /home/master/file_crontab.txt
echo "Cron ejecutandose!" >> /home/master/file_crontab.txt
echo ""

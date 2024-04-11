#!/bin/bash
set -e
echo "Docker container ha iniciado"
printf "\n\033[0;44m---> Inicia SSH server <--- \033[0m\n"
service ssh start
service ssh status
printf "\n\033[0;44m---> Inicia el Crontab <--- \033[0m\n"
service cron restart 
exec "$@"

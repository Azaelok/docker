#!/bin/bash
echo "Inicia la creacion de laS llaves SSH!"
ssh-keygen -f /home/master/.ssh/id_rsa -t RSA -b 2048
echo "Finaliza la creacion de laS llaves SSH!"

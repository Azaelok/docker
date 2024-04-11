#!/bin/bash

entrada=$1
  case $entrada in
    "REPORTES_EDO_CUENTA")
      echo ""
      echo "Inicia el proceso de Descifrado REPORTES EDO CUENTA."
      # script descifrado                # Ruta Inbox                         # Ruta passphrase              # Ruta Respaldo PGP's                            # Ruta Logs Descifrado
      /etc/cron.d/./script_descifrado.sh /home/master/ESTADO_DE_CUENTA_INBOX/ /home/master/passphrase/pgpass /home/master/ESTADO_DE_CUENTA_INBOX/respaldoPGP/ /home/master/ESTADO_DE_CUENTA_INBOX/logsDescifrado/
      ;;
    "*")
      echo "Parámetro Inválido!.";;
  esac
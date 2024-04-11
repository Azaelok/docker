#!/bin/bash
gpg --verbose --batch --gen-key /home/master/conf_gpg
gpg -k
gpg --export -a --output public_key_PGP_cliente.asc master@gmail.com

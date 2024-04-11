gpg --import /home/master/LLAVE_PUBLICA_PGP_BAZ.asc
(echo trust && echo 5 && echo y && echo quit) | gpg --no-tty --command-fd 0 --edit-key prueba1@prueba.com

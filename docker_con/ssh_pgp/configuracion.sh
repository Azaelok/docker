#!/bin/bash
set -e
mkdir -p /home/${SSH_MASTER_USER}/.ssh/
chmod 700 /home/${SSH_MASTER_USER}/.ssh/
mkdir -p /home/${SSH_MASTER_USER}/.gnupg/
chmod 700 /home/${SSH_MASTER_USER}/.gnupg/
mkdir -p /home/${SSH_MASTER_USER}/passphrase/
chmod 766 /home/${SSH_MASTER_USER}/passphrase/
cat > /home/${SSH_MASTER_USER}/passphrase/pgpass <<EOF
temporal
EOF
chown master:master -R /home/${SSH_MASTER_USER}/
cat > /home/${SSH_MASTER_USER}/conf_gpg <<EOF
    %echo Inicia la creacion de laS llaves GPG
    Key-Type: RSA
    Key-Length: 2048
    Subkey-Type: RSA
    Subkey-Length: 2048
    Name-Real: test_gpg
    Name-Comment: keys_test
    Name-Email: master@gmail.com
    Expire-Date: 0
    Passphrase:temporal
    #%pubring foo.pub
    #%secring foo.sec
    # Do a commit here, so that we can later print "done" :-)
    %commit
    %echo done
EOF
chmod 666 /home/${SSH_MASTER_USER}/conf_gpg
chown master:master /home/${SSH_MASTER_USER}/conf_gpg

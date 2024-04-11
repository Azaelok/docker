FROM debian:latest

ARG SSH_MASTER_USER
ARG SSH_MASTER_PASS
ENV TZ="America/Mexico_City" 
RUN apt-get -q -y update
RUN apt-get install -y --no-install-recommends
RUN apt-get install -y vim
RUN apt install -y sudo
RUN apt-get install -y gnupg2
RUN apt-get install -y cron
COPY ./user/user.sh /usr/local/bin/user.sh
RUN chmod 777 /usr/local/bin/user.sh
RUN /usr/local/bin/user.sh
RUN rm /usr/local/bin/user.sh
COPY ./ssh_pgp/ssh_keys.sh /home/master/ssh_keys.sh
RUN chmod +x /home/master/ssh_keys.sh
RUN su - master -c /home/master/ssh_keys.sh
RUN rm /home/master/ssh_keys.sh
COPY ./ssh_pgp/configuracion.sh /usr/local/bin/configuracion.sh
RUN chmod +x /usr/local/bin/configuracion.sh
RUN /usr/local/bin/configuracion.sh
RUN rm /usr/local/bin/configuracion.sh
COPY ./ssh_pgp/pgp_keys.sh /home/master/pgp_keys.sh
RUN chmod +x /home/master/pgp_keys.sh
RUN su - master -c /home/master/pgp_keys.sh
RUN rm /home/master/pgp_keys.sh
RUN rm /home/master/conf_gpg
COPY ./llaves_BAZ/LLAVE_PUBLICA_PGP_BAZ.asc /home/master/LLAVE_PUBLICA_PGP_BAZ.asc
RUN chmod +x /home/master/LLAVE_PUBLICA_PGP_BAZ.asc
COPY ./ssh_pgp/certificacion_pgp.sh /home/master/certificacion_pgp.sh
RUN chmod +x /home/master/certificacion_pgp.sh
RUN su - master -c "/home/master/certificacion_pgp.sh"
COPY ./cifrado_descifrado/master.sh /etc/cron.d/master.sh
COPY ./cifrado_descifrado/script_cifrado.sh /etc/cron.d/script_cifrado.sh
COPY ./cifrado_descifrado/script_descifrado.sh /etc/cron.d/script_descifrado.sh
RUN sed -i -e 's/\r$//' /etc/cron.d/master.sh
RUN sed -i -e 's/\r$//' /etc/cron.d/script_cifrado.sh
RUN sed -i -e 's/\r$//' /etc/cron.d/script_descifrado.sh
RUN chmod 757 /etc/cron.d/master.sh      
RUN chmod 757 /etc/cron.d/script_cifrado.sh   
RUN chmod 757 /etc/cron.d/script_descifrado.sh
RUN touch /var/log/cron.log
RUN echo :wq | crontab -e
RUN echo "*/10 * * * * su - master -c \"/etc/cron.d/master.sh REPORTES_EDO_CUENTA\"" >> /var/spool/cron/crontabs/root
RUN rm /home/master/LLAVE_PUBLICA_PGP_BAZ.asc
RUN rm /home/master/certificacion_pgp.sh
EXPOSE 22
CMD cron && tail -f /var/log/cron.log

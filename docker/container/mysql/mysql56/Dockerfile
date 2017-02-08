FROM mysql:5.6

ADD ./my.cnf /etc/mysql/my.cnf
ADD ./run.sh /root/run.sh
ADD ./my-home.cnf /root/.my.cnf
RUN chmod 0600 /root/.my.cnf
#CMD ["/root/run.sh"]

WORKDIR /var/www/domains

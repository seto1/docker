#!/bin/sh

# mysql
if [ ! -d /var/lib/mysql/mysql ]; then
  su mysql -c "mysqld --initialize-insecure" -s /bin/sh
fi

rm -f /var/lib/mysql/mysql.sock
rm -f /var/lib/mysql/mysql.sock.lock

su mysql -c "mysqld &" -s /bin/sh
sleep 10s
mysql -u root -e "CREATE USER ${MYSQL_USER} IDENTIFIED BY '${MYSQL_PASSWORD}'"
mysql -u root -e "grant all privileges on *.* to ${MYSQL_USER}@\"%\""
mysql -u root -e "SET GLOBAL sql_mode = ''"

# apache
rm -f /etc/httpd/conf.d/welcome.conf
httpd -D FOREGROUND

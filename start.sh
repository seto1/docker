#!/bin/sh

# mysql
if [ ! -d /var/lib/mysql/mysql ]; then
  su mysql -c "mysqld --initialize-insecure" -s /bin/sh
  empty_mysql=1
fi

rm -f /var/lib/mysql/mysql.sock
rm -f /var/lib/mysql/mysql.sock.lock

su mysql -c "mysqld &" -s /bin/sh
if [ $empty_mysql = 1 ]; then
  sleep 5s
  mysql -u root -e "CREATE USER ${MYSQL_USERNAME} IDENTIFIED BY '${MYSQL_PASSWORD}'"
  mysql -u root -e "grant all privileges on *.* to ${MYSQL_USERNAME}@\"%\""
  mysql -u root -e "SET GLOBAL sql_mode = ''"
fi

# apache
rm -f /etc/httpd/conf.d/welcome.conf
httpd -D FOREGROUND

#!/bin/bash


sleep 30

pass=$(cat /var/log/mysqld.log | grep -i 'temporary password' | awk '{print $NF}')

SECURE_MYSQL=$(expect -c "

set timeout 10
spawn mysql_secure_installation

expect \"Enter password for user root:\"
send -- \"$pass\r\"

expect \"New password:\"
send \"Welcome@2023\r\"

expect \"Re-enter new password:\"
send \"Welcome@2023\r\"

expect \"Change the password for root ? ((Press y|Y for Yes, any other key for No) :\"
send \"yes\r\"

expect \"New password:\"
send \"Welcome@2023\r\"

expect \"Re-enter new password:\"
send \"Welcome@2023\r\"

expect \"Do you wish to continue with the password provided?(Press y|Y for Yes, any other key for No) :\"
send \"yes\r\"

expect \"Remove anonymous users? (Press y|Y for Yes, any other key for No) :\"
send \"yes\r\"

expect \"Disallow root login remotely? (Press y|Y for Yes, any other key for No) :\"
send \"yes\r\"

expect \"Remove test database and access to it? (Press y|Y for Yes, any other key for No) :\"
send \"yes\r\"

expect \"Reload privilege tables now? (Press y|Y for Yes, any other key for No) :\"
send \"yes\r\"

expect eof
")

echo "$SECURE_MYSQL"

sleep 7

mysql -u root -pWelcome@2023 -e "CREATE USER 'otrs'@'%' IDENTIFIED WITH mysql_native_password BY 'Otrs@123';"

mysql -u root -pWelcome@2023 -e "GRANT USAGE ON *.* TO 'otrs'@'%';"

mysql -u root -pWelcome@2023 -e "ALTER USER 'otrs'@'%' REQUIRE NONE WITH MAX_QUERIES_PER_HOUR 0 MAX_CONNECTIONS_PER_HOUR 0 MAX_UPDATES_PER_HOUR 0 MAX_USER_CONNECTIONS 0;"

mysql -u root -pWelcome@2023 -e 'CREATE DATABASE IF NOT EXISTS `otrs`;'

mysql -u root -pWelcome@2023 -e 'GRANT ALL PRIVILEGES ON `otrs`.* TO "otrs"@"%";'


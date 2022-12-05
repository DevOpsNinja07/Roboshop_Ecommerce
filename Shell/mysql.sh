source common.sh
if [ -z "$1" ]; then
  echo "INPUT PASSWORD ARGUMENT!!"
  exit
fi
RoboShopMYSQLPASS=$1

PRINT Downloading Repo
curl -s -L -o /etc/yum.repos.d/mysql.repo https://raw.githubusercontent.com/roboshop-devops-project/mysql/main/mysql.repo
STATISTICS $?

PRINT Disabling mysql v8
dnf module disable mysql -y
STATISTICS $?

PRINT installing mysql
yum install mysql-community-server -y
STATISTICS $?

PRINT  starting and enabling mysql services
systemctl enable mysqld
systemctl start mysqld
STATISTICS $?

echo show databases | mysql -uroot -p${RoboShopMYSQLPASS}
if [ $? -ne 0 ]; then
echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '${RoboShopMYSQLPASS}' ; " > /tmp/root-pass-sql
DEFAULTPASS=$(grep 'A temporary password ' /var/log/mysqld.log | awk '{print $NF}')
cat /tmp/root-pass-sql | mysql --connect-expired-password -uroot -p"${DEFAULTPASS}"

fi
PRINT password change
STATISTICS $?
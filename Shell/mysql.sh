source common.sh
if [ -z "$1" ]; then
  echo "INPUT PASSWORD ARGUMENT!!"
  exit
fi
RoboShopMYSQLPASS=$1

PRINT Downloading Repo
curl -s -L -o /etc/yum.repos.d/mysql.repo https://raw.githubusercontent.com/roboshop-devops-project/mysql/main/mysql.repo
if [ $? -eq 0 ]; then
  echo SUCESS
else
  echo FAILURE
fi

echo Disabling mysql v8
dnf module disable mysql -y
if [ $? -eq 0 ]; then
  echo SUCESS
else
  echo FAILURE
fi
echo installing mysql
yum install mysql-community-server -y

if [ $? -eq 0 ]; then
  echo SUCESS
else
  echo FAILURE
fi
echo starting services
systemctl enable mysqld
systemctl start mysqld
if [ $? -eq 0 ]; then
  echo SUCESS
else
  echo FAILURE
fi

echo show databases | mysql -uroot -p${RoboShopMYSQLPASS}
if [ $? -ne 0 ]; then
echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '${RoboShopMYSQLPASS}' ; " > /tmp/root-pass-sql
DEFAULTPASS=$(grep 'A temporary password ' /var/log/mysqld.log | awk '{print $NF}')
cat /tmp/root-pass-sql | mysql --connect-expired-password -uroot -p"${DEFAULTPASS}"

fi
echo password change
if [ $? -eq 0 ]; then
  echo SUCESS
else
  echo FAILURE
fi
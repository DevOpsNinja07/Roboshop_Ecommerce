curl -s -L -o /etc/yum.repos.d/mysql.repo https://raw.githubusercontent.com/roboshop-devops-project/mysql/main/mysql.repo
dnf module disable mysql -y
yum install mysql-community-server -y
systemctl enable mysqld
systemctl start mysqld
#DEFAULTPASS=$(grep temp /var/log/mysqld.log | awk '{print $NF}')
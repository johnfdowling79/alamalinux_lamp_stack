#!/bin/bash
set -e

MYSQL_ROOT_PASSWORD="Passw0rd1!"

echo "Updating system..."
dnf update -y

echo "Installing MySQL repo..."
dnf install -y https://dev.mysql.com/get/mysql80-community-release-el9-1.noarch.rpm

echo "Importing GPG keys..."
rpm --import https://repo.mysql.com/RPM-GPG-KEY-mysql-2022 || true
rpm --import https://repo.mysql.com/RPM-GPG-KEY-mysql-2023 || true

echo "Fixing repo key..."
sed -i 's|gpgkey=.*|gpgkey=https://repo.mysql.com/RPM-GPG-KEY-mysql-2023|' /etc/yum.repos.d/mysql-community.repo

echo "Disabling default MySQL module..."
dnf module disable mysql -y

echo "Installing MySQL server..."
dnf install -y mysql-community-server

echo "Starting MySQL..."
systemctl enable --now mysqld

echo "Waiting for MySQL to initialize..."
sleep 5

echo "Getting temporary password..."
TEMP_PASS=$(grep 'temporary password' /var/log/mysqld.log | awk '{print $NF}')

echo "Setting root password..."

mysql --connect-expired-password -u root -p"${TEMP_PASS}" <<EOF
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
FLUSH PRIVILEGES;
EOF

echo "✅ MySQL root password set to: ${MYSQL_ROOT_PASSWORD}"
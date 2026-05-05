sudo dnf update -y
sudo crb enable

echo "install firewall"
sudo dnf install -y firewalld
sudo dnf install -y httpd
sudo dnf install -y epel-release
sudo firewall-cmd --add-port=80/tcp
sudo firewall-cmd --add-port=3306/tcp
sudo firewall-cmd --add-service=http
sudo firewall-cmd --add-service=mysql

echo "install php"
sudo dnf install -y https://rpms.remirepo.net/enterprise/remi-release-9.rpm
sudo dnf module reset php -y
sudo dnf module enable php:remi-8.5 -y
sudo dnf install -y php php-cli php-fpm php-mysqlnd php-pgsql php-gd php-mbstring php-xml php-curl php-zip php-intl php-opcache php-soap
sudo reboot
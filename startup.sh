
sudo setenforce 0
sudo chmod 777 -R /var/www/html
sudo chown vagrant:vagrant -R /var/www/html
sudo chmod 777 -R  /run/php-fpm/www.sock
sudo chown vagrant:vagrant /run/php-fpm/www.sock

echo "start firewall"
sudo firewall-cmd --add-port=80/tcp
sudo firewall-cmd --add-port=3306/tcp
sudo firewall-cmd --add-service=http
sudo firewall-cmd --reload

echo "copy apache config"
sudo cp /mnt/config/httpd.conf /etc/httpd/conf/httpd.conf

echo "start php"
sudo systemctl enable php-fpm
sudo systemctl start php-fpm

echo "start database"
sudo systemctl enable --now mysqld

echo "start web service"
sudo systemctl enable httpd
sudo systemctl start httpd

echo "run privilege on the database"
mysql -u root -p'Passw0rd1!' < /mnt/config/set_users.sql

sudo firewall-cmd --add-service=http
sudo firewall-cmd --add-port=3306/tcp
echo "Finished"
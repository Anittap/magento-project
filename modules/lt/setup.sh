#!/bin/bash

echo "ClientAliveInterval 60" >> /etc/ssh/sshd_config
systemctl restart sshd.service

hostnamectl set-hostname taxi1-home.ap-south-1.compute.internal
yum install httpd php -y

echo "testing" > /var/www/html/health.html 

cat <<EOF > /var/www/html/index.php
<?php
\$output = shell_exec('echo $HOSTNAME');
echo "<h1><center><pre>\$output</pre></center></h1>";
echo "<h1><center>terraform version 1</center></h1>";
?>
EOF

systemctl restart httpd.service php-fpm.service
systemctl enable httpd.service php-fpm.service


#!/bin/bash

# sleep until instance is ready
until [[ -f /var/lib/cloud/instance/boot-finished ]]; do
    sleep 1
done

# Install Apache
apt-get update
apt-get install apache2 -y 

echo "This Web page can only be accessed from United Arab Emirates or United Kingdom" > /var/www/html/index.html

# allow access on ports 80 and 443
# ufw enable 
# ufw allow 'Apache Full'

# make sure Apache is started
systemctl start apache2
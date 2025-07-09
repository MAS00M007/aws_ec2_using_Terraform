#!/bin/bash

# Update package list and install prerequisites
sudo apt update
sudo apt-get install nginx -y
# Start Nginx service
sudo systemctl start nginx
# Enable Nginx to start on boot
sudo systemctl enable nginx

# Check the status of Nginx
echo "<h1>Nginx Installation Successful</h1>" | sudo tee /var/www/html/index.html
# Display the status of Nginx
echo "Nginx service status:"
sudo systemctl status nginx
#!/bin/bash
sudo wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
sudo add-apt-repository universe
sudo apt-get update
sudo apt-get install -y apt-transport-https \
    dotnet-sdk-2.1 \
    nginx

sudo mkdir /var/www/dotnetapp
sudo cp -r /vagrant/output/* /var/www/dotnetapp
sudo cp -r /vagrant/nginx/default /etc/nginx/sites-available/default

sudo cat > /etc/systemd/system/dotnetapp.service  << EOF
[Unit]
Description=Basic Dotnet Core Application

[Service]
WorkingDirectory=/var/www/dotnetapp
ExecStart=/usr/bin/dotnet /var/www/dotnetapp/DotnetApp.dll
Restart=always
RestartSec=30
KillSignal=SIGINT
SyslogIdentifier=dotnetapp
User=www-data
Environment=ASPNETCORE_ENVIRONMENT=Production
Environment=DOTNET_PRINT_TELEMETRY_MESSAGE=false
Environment=ASPNETCORE_URLS=http://*:5000

[Install]
WantedBy=multi-user.target
EOF
sudo systemctl daemon-reload
sudo systemctl enable dotnetapp.service
sudo systemctl start dotnetapp.service
sudo systemctl restart nginx.service
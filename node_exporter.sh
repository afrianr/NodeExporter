#!/bin/bash
# This script will install Node Exporter with systemd
VERSION="1.10.2"
sudo curl -LO "https://github.com/prometheus/node_exporter/releases/download/v$VERSION/node_exporter-$VERSION.linux-amd64.tar.gz"
sudo tar xvfz node_exporter-$VERSION.linux-amd64.tar.gz -C /opt/
sudo mv node_exporter-$VERSION.linux-amd64/node_exporter /opt/node_exporter/
cat << EOF >node_exporter.service
[Unit]
Description=Node Exporter

[Service]
User=root
ExecStart=/opt/node_exporter/node_exporter

[Install]
WantedBy=default.target
EOF

sudo mv node_exporter.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable node_exporter.service
sudo systemctl start node_exporter.service
sudo systemctl status node_exporter.service
#sudo rm -rf node_exporter-$VERSION.linux-amd64.tar.gz
#sudo rm -f node_exporter.sh

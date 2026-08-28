#!/bin/bash
set -e

VERSION="1.10.2"
INSTALL_DIR="/opt/node_exporter"

curl -fLO "https://github.com/prometheus/node_exporter/releases/download/v${VERSION}/node_exporter-${VERSION}.linux-amd64.tar.gz"

tar -xzf "node_exporter-${VERSION}.linux-amd64.tar.gz" -C /opt/

mkdir -p "${INSTALL_DIR}"

mv "/opt/node_exporter-${VERSION}.linux-amd64/node_exporter" \
   "${INSTALL_DIR}/node_exporter"

chmod 0755 "${INSTALL_DIR}/node_exporter"

cat > /etc/systemd/system/node_exporter.service <<EOF
[Unit]
Description=Node Exporter
After=network-online.target
Wants=network-online.target

[Service]
User=root
ExecStart=${INSTALL_DIR}/node_exporter
Restart=on-failure
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable --now node_exporter

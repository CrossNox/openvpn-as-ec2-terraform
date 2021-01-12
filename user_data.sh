#! /bin/bash
yum update -y
amazon-linux-extras install docker -y
service docker start
usermod -a -G docker ec2-user
chkconfig docker on

mkdir /home/ec2-user/openvpn-config

cat > /etc/systemd/system/openvpn.service<< EOF
[Unit]
Description=openvpn

[Service]
WorkingDirectory=/home/ec2-user
ExecStart=/usr/bin/docker run -d \
  --name=openvpn-as \
  --cap-add=NET_ADMIN \
  -e PUID=1000 \
  -e PGID=1000 \
  -p 943:943 \
  -p 443:9443 \
  -p 1194:1194/udp \
  -v /home/ec2-user/openvpn-config:/config \
  --restart unless-stopped \
  ghcr.io/linuxserver/openvpn-as
Restart=on-failure
RestartSec=30s
User=ec2-user
[Install]
WantedBy=default.target
EOF


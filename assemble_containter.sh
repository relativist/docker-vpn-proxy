#!/usr/bin/env bash

mkdir -p certificates
cd certificates

#1. fetch fresh certificates from www.vpnbook.com to folder "certificates/"
wget https://www.vpnbook.com/free-openvpn-account/VPNBook.com-OpenVPN-FR1.zip
unzip -u VPNBook.com-OpenVPN-FR1.zip
rm VPNBook.com-OpenVPN-FR1.zip*
ls -la

#2. fetch fresh login and password for vpn
echo "vpnbook" > creds.txt
wget -O 1.png https://www.vpnbook.com/password.php


answer=$(yad --center --title="PASSWORD" \
--image-on-top \
--text-align=left \
--text="Input below:" \
--image="1.png" \
--form \
--field="")

answer=$(echo $answer | tr -d '|')
echo $answer

echo $answer >> creds.txt

#3. assemble docker image with name vpnka
cd ../
docker build -f Dockerfile --tag=vpnka:latest .

#4. calculate docker-compose.yml


#docker exec -it vpnka bash
#docker run -it retriever bash
#wget -qO- http://ipecho.net/plain ; echo
#wget -e use_proxy=yes -e http_proxy=127.0.0.1:3128  -qO- http://ipecho.net/plain ; echo
#wget -e use_proxy=yes -e http_proxy=127.0.0.1:8888  -qO- ipinfo.io/ip
#$ curl ifconfig.co
#$ curl ifconfig.me
#$ curl icanhazip.com
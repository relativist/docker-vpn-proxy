#!/bin/bash

docker kill vpner

prev_ip=$(wget -e use_proxy=yes -qO- http://ipecho.net/plain ; echo)
echo "BEFORE: "$prev_ip

echo "starting... vpn"
docker run -d --rm --cap-add=NET_ADMIN --device /dev/net/tun --name vpner -v /home/sit/IdeaProjects/delivery/delivery-service/ZipCodeRetriever/vpn:/vpn -p "8888:3128" --dns=8.8.4.4 --dns=8.8.8.8 tsari/openvpn && \
sleep 3 && \
docker exec -d vpner openvpn --cd /vpn --config /vpn/vpnbook-fr1-udp53.ovpn --auth-user-pass creds.txt --management localhost 9999

echo "started vpn"

for ((i=10;i>0;i--));
do
   echo $i
   sleep 1
done

second_ip=$(wget -e use_proxy=yes -e http_proxy=127.0.0.1:8888  -qO- http://ipecho.net/plain; echo)
echo "AFTER: "$prev_ip

if [ "$prev_ip" != "$second_ip" ]; then
  echo "SUCCESS! VPN is OPENED ON localhost:8888"
  else echo "FAIL: IP NOT CHANGED!"
fi

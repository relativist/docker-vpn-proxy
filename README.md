# docker-vpn-proxy
Docker container with squid proxy and openvpn client.(use vpnbook.com)

The container is listening on port 8888. So you can use the container to route only specific traffic through a vpn.

Download archieve from site vpnbook.com, extract to folder and change config. (fix creds before run)

# Start
Requirements: yad, docker, docker-compose, unzip, wget 
1. ./assemble_containter.sh

2. docker-compose up -d

## Another Way
docker run -d --rm --cap-add=NET_ADMIN --device /dev/net/tun --name vpner -v /home/sit/tmp/vpn-proxy/vpns:/vpn -p "8888:3128" --dns=8.8.4.4 --dns=8.8.8.8 tsari/openvpn

docker exec -d vpner openvpn --cd /vpn --config /vpn/vpnbook-fr1-udp53.ovpn --auth-user-pass creds.txt --management localhost 9999

## Verify IP ADDRESS
wget -e use_proxy=yes -e http_proxy=localhost:8888  -qO- http://ipecho.net/plain ; echo

curl -x http://localhost:8888 ifconfig.co

curl -x http://localhost:3128 ifconfig.co

#dump a traffic from ips
sudo tcpdump -i enp3s0 -n -nn -vvv -A host 216.239.34.21 or host 216.239.32.21 or host 216.239.36.21

#get my IP
wget -e use_proxy=yes -e http_proxy=127.0.0.1:8888  -qO- http://ipecho.net/plain ; echo

wget -e use_proxy=yes -e http_proxy=127.0.0.1:8888  -qO- ipinfo.io/ip

wget -qO- http://ipecho.net/plain ; echo

curl ifconfig.co

curl ifconfig.me

curl icanhazip.com

lynx -source ipinfo.io/ip

#Go to container
docker exec -it vpnka bash
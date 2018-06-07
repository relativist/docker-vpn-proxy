# docker-vpn-proxy
Docker container with squid proxy and openvpn client.(use vpnbook.com)

The container is listening on port 3128. So you can use the container to route only specific traffic through a vpn.

## BUILD
docker build --tag=vpnka:latest .
docker-compose up

## Another Way
docker run -d --rm --cap-add=NET_ADMIN --device /dev/net/tun --name vpner -v /home/sit/tmp/vpn-proxy/vpns:/vpn -p "8888:3128" --dns=8.8.4.4 --dns=8.8.8.8 tsari/openvpn
docker exec -d vpner openvpn --cd /vpn --config /vpn/vpnbook-fr1-udp53.ovpn --auth-user-pass creds.txt --management localhost 9999

So it's easily to run: 
./create_docker_vpn_proxy.sh


## Verify IP ADDRESS

wget -e use_proxy=yes -e http_proxy=localhost:3128  -qO- http://ipecho.net/plain ; echo
curl -x http://localhost:8888 ifconfig.co
curl -x http://localhost:3128 ifconfig.co


 #!/bin/sh
d=$(date)
echo "started at $d"
echo "Now we run the file: "${VPN_FILE_NAME}

/usr/sbin/openvpn --config /vpn/${VPN_FILE_NAME} --auth-user-pass creds.txt --management localhost 9999 &
sleep 10
/usr/sbin/squid3 -f /etc/squid/squid.conf -N


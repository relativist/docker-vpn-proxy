 #!/bin/sh
d=$(date)
echo "started at $d"
echo "Now we run the file: "${VPN_FILE_NAME}

/usr/sbin/openvpn --config ${VPN_FILE_NAME} --auth-user-pass creds.txt --management localhost 9999 &
sleep 15
/usr/sbin/squid3 -f /etc/squid/squid.conf -N


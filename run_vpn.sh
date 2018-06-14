 #!/bin/sh
d=$(date)
echo "started at $d"
echo "Now we runn the file: "${VPN_FILE}
/usr/bin/supervisord &
echo "sleep 10sec"
sleep 10

echo "run"
/usr/sbin/openvpn --config /vpn/${VPN_FILE} --auth-user-pass /vpn/creds.txt --management localhost 9999

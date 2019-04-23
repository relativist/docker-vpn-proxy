 #!/bin/sh
d=$(date)
echo "started at $d"
echo "Now we run the file: "${VPN_FILE_NAME}

old_ip=$(curl ifconfig.me)
echo "-------------------------------------"
echo "OLD IP : "$old_ip
echo "-------------------------------------"
/usr/sbin/openvpn --config ${VPN_FILE_NAME} --auth-user-pass creds.txt --management localhost 9999 &


for var in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
do
sleep 1
echo $var
done


new_ip=$(curl ifconfig.me)
echo "-------------------------------------"
echo "NEW IP : "$new_ip
echo "-------------------------------------"
if [ $old_ip == $new_ip ]
then
	echo "FAIL!"
else
	echo "SUCCESS!"
fi
echo "-------------------------------------"

/usr/sbin/squid3 -f /etc/squid/squid.conf -N 
#sleep 100000


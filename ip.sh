#!/bin/bash

ErrorIP=""
ErrorSendFlag=0

while :
do

ErrorIP=""

	for ip in 192.168.74.4 192.168.74.101 192.168.0.101 10.74.19.42 10.99.1.42 10.99.10.42 10.99.12.20 10.224.0.44 10.224.0.45 10.224.0.53
	do
		pingOtvet=`fping ${ip}`

		if [ "$pingOtvet" = "${ip} is alive" ]; then
			echo "OK === $ip"
		else
			echo "ERROR === $ip"
			ErrorIP+="${ip}, "
		fi
	done

	if [ "${ErrorIP}" = "" ]; then
		echo "IP ALL OK"
		ErrorSendFlag=0
	else
		echo "IP ALL ERROR === ${ErrorIP}"

		if [ "$ErrorSendFlag" = 0 ]; then
			ErrorSendFlag=1
			echo "IP: ${ErrorIP}" | mutt -s "Не доступны IP" -- andrey-21x6@mail.ru
		fi
	fi
	
    echo "ErrorSendFlag = ${ErrorSendFlag}"
    echo ""
    echo ""
    sleep 60

done

#!/bin/sh


bp1=`/bin/cat /sys/bus/i2c/devices/6-0026/bypass0`
bp2=`/bin/cat /sys/bus/i2c/devices/6-0022/bypass0`
ovpnstatus=`/sbin/service openvpn status`
ovpn=1

if [[ $bp1 == "2" ]]; then
	if [[ $bp2 == "2" ]]; then
		:
		if [[ $ovpnstatus == "Status written to /var/log/messages" ]]; then
			ovpn=1
			echo up
		else
			/sbin/service openvpn start
			ovpn=2
		fi
		/usr/bin/yum -y update
		/usr/sbin/clearcenter-checkin
		
		if [[ $ovpn == "2" ]]; then
			/sbin/service openvpn stop
		fi
	fi
fi


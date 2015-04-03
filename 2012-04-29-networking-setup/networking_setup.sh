#!/bin/sh

# Script to setup VirtualBox Debian/Ubuntu hostname and networking.
# This is designed to be executed after setting up a new VM from an OVA
# appliance file, to more quickly facilitate setup.
#
# Note that this assumes a specific VirtualBox VM Network configuration:
#   Network
#     Adapter 1
#       Attached to: NAT
#     Adapter 2
#       Attached to: Host-only Adapter
#       Name:        vboxnet0 (or some other configured Network)
#
# The configuration is set up like this to enable the VM to directly
# access the internet using NAT, but also for the Host to be able to
# access the VM directly, perhaps using dnsmasq.


# = Get settings

echo    "Current hostname : `hostname`"
echo -n "New hostname     : "
read hostname

echo    "Current eth1 ip  : `ifconfig eth1 | sed -n 2p | cut -d ':' -f2 | cut -d ' ' -f1`"
echo -n "New eth1 ip      : "
read ip


# = Configure hostname

if [ "$hostname" ]; then
	echo "$hostname" > /etc/hostname
	/etc/init.d/hostname.sh
	echo "Configured hostname"
else
	echo "Skipped hostname configuration"
fi


# = Configure networking

if [ "$ip" ]; then
	echo "
		auto lo
		iface lo inet loopback
		
		auto eth0
		iface eth0 inet dhcp
		
		auto eth1
		iface eth1 inet static
			address $ip
			netmask 255.255.255.0
	" > /etc/network/interfaces
	service networking restart
	echo "Configured networking"
else
	echo "Skipped networking configuration"
fi

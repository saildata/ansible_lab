#!/bin/bash
# Block every IP or hostname in blocklist.txt

for i in $(cat /etc/blocklist.txt); do
	echo "Blocking all traffic to and from $i"
	/sbin/iptables -I INPUT -s $i -j DROP
	/sbin/iptables -I OUTPUT -d $i -j REJECT
done

# Remove any duplicates
iptables-save | awk '!($0 in a) { a[$0]; print }' | iptables-restore

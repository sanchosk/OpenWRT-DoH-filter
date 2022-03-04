#!/bin/ash

# this script downloads the DOH list from https://raw.githubusercontent.com/jpgpi250/piholemanual/master/DOHipv4.txt
# checks if the download was successful
# replaces the file in the configuration
# and reloads the ipset

targetFile=/tmp/DOHlist.txt

# downloading the file
[ -f $targetFile ] && rm $targetFile
wget -q -O $targetFile "https://raw.githubusercontent.com/jpgpi250/piholemanual/master/DOHipv4.txt"

# checking if the downloaded file is greated than 1000 bytes
fSize=$(ls -al $targetFile | awk '{ print $5; }')
[ $fSize -lt 1000 ] && echo "small file! Exitting" && exit

# file is OK, let's replace the existing one
mv $targetFile /tmp/DOH.txt

# first, check if ipset list exists
listExists=$(ipset list | grep DoH | wc -l)
[ $listExists -ge 1 ] && echo "List exists" || ipset create DoH hash:ip

# flush existing data from list
ipset flush DoH

# load DoH data line-by-line
cat /tmp/DOH.txt | while read line; do ipset add DoH $line; done


# list loaded, block the IPtables
[ $(iptables -L OUTPUT   | grep DoH | wc -l) -gt 0 ] || iptables -A OUTPUT  -m set --match-set DoH src -j DROP
[ $(iptables -L INPUT    | grep DoH | wc -l) -gt 0 ] || iptables -A INPUT   -m set --match-set DoH dst -j DROP
[ $(iptables -L FORWARD  | grep DoH | wc -l) -gt 0 ] || iptables -A FORWARD -m set --match-set DoH dst -j DROP

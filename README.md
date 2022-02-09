This script will use the Pi-Hole project's list of servers running DNS over HTTPs and create an iptable ip set list for blocking it.

# Usage
Copy the file to your OpenWRT machine to /etc/ folder using scp.
Make the file executable by running
`chmod a+x /etc/DOHfilter.sh`
Create a crontab record to run the script daily:
`echo "3   3  *  *  *       /etc/DOHfilter.sh" >> /etc/crontabs/root

Make sure the `ipset` and the `iptables` packages are installed
If you are using snapshot maybe your router kernel is outdated, then you have to update the Openwrt first (the Openwrt will notify you when try to install `ipset` via LuCi (GUI))

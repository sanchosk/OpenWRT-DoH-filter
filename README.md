This script will use the Pi-Hole project's list of servers running DNS over HTTPs and create an iptable ip set list for blocking it.

# Usage
Copy the file to your OpenWRT machine to /etc/ folder using scp.
Make the file executable by running
`chmod a+x /etc/DOHfilter.sh`
Create a crontab record to run the script daily:
`echo "3   3  *  *  *       /etc/DOHblock.sh" >> /etc/crontabs/root


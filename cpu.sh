#!/bin/bash
SAR_OUTPUT=`sar | grep user`
#-------------------------------------------------------------------
SAR_FORMAT='[0-9][0-9]:[0-9][0-9]:[0-9][0-9]\s+.M\s+CPU\s+%user\s+%nice\s+%system\s+%iowait\s+%steal\s+%idle'
if [[ $SAR_OUTPUT =~ $SAR_FORMAT ]]; then
	echo "Hostname,Time AM/PM,%(user+system+iowait),%idle"
	SAR_HOSTNAME=`hostname`
	sar -P ALL | grep all | grep -e AM -e PM | awk -v sar_hostname="$SAR_HOSTNAME" 'BEGIN {OFS=","} {print sar_hostname,$1" "$2,$4+$6+$7,$9}'
else
	echo "sar format error"
fi

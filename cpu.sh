#!/bin/bash
SAR_OUTPUT=`sar | grep user`
SAR_HOSTNAME=`hostname`
#-------------------------------------------------------------------
SAR_FORMAT_EN='[0-9][0-9]:[0-9][0-9]:[0-9][0-9]\s+.M\s+CPU\s+%user\s+%nice\s+%system\s+%iowait\s+%steal\s+%idle'
SAR_FORMAT_JA='[0-9][0-9]時[0-9][0-9]分[0-9][0-9]秒\s+CPU\s+%user\s+%nice\s+%system\s+%iowait\s+%steal\s+%idle'
#-------------------------------------------------------------------
if [[ $SAR_OUTPUT =~ $SAR_FORMAT_EN ]]; then
	echo "Hostname,Time AM/PM,%(user+system+iowait),%idle"
	sar -P ALL | grep all | grep -e AM -e PM | awk -v sar_hostname="$SAR_HOSTNAME" 'BEGIN {OFS=","} {print sar_hostname,$1" "$2,$4+$6+$7,$9}'
elif [[ $SAR_OUTPUT =~ $SAR_FORMAT_JA ]]; then
	echo "Hostname,Time AM/PM,%(user+system+iowait),%idle"
	sar -P ALL | grep all | grep -e 秒 | awk -v sar_hostname="$SAR_HOSTNAME" 'BEGIN {OFS=","} {print sar_hostname,$1" "$2,$4+$6+$7,$9}'
else
	echo "sar format error"
fi

#!/bin/bash
SAR_OUTPUT=`sar -r | grep kbmem`
SAR_HOSTNAME=`hostname`
#-------------------------------------------------------------------
SAR_FORMAT_EN='[0-9][0-9]:[0-9][0-9]:[0-9][0-9]\s+.M\s+.*%memused'
SAR_FORMAT_JA='[0-9][0-9]時[0-9][0-9]分[0-9][0-9]秒\s+.*%memused'
#-------------------------------------------------------------------
if [[ $SAR_OUTPUT =~ $SAR_FORMAT_EN ]]; then
	echo "Hostname,Time AM/PM,%memused"
	sar -r | grep -v %memused | grep -e AM -e PM | awk -v sar_hostname="$SAR_HOSTNAME" 'BEGIN {OFS=","} {print sar_hostname,substr($1,1,length($1)-3)" "$2,$6}'
elif [[ $SAR_OUTPUT =~ $SAR_FORMAT_JA ]]; then
	echo "Hostname,Time AM/PM,%memused"
	sar -r | grep -v %memused | grep -e 秒 | awk -v sar_hostname="$SAR_HOSTNAME" 'BEGIN {OFS=","} {print sar_hostname,substr($1,1,length($1)-3),$5}'
else
	echo "sar format error"
fi

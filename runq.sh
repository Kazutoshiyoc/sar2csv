#!/bin/bash
SAR_OUTPUT=`sar -q | grep runq-sz`
SAR_HOSTNAME=`hostname`
#-------------------------------------------------------------------
SAR_FORMAT_EN='[0-9][0-9]:[0-9][0-9]:[0-9][0-9]\s+.M\s+runq-sz.*'
SAR_FORMAT_JA='[0-9][0-9]時[0-9][0-9]分[0-9][0-9]秒\s+runq-sz.*'
#-------------------------------------------------------------------
if [[ $SAR_OUTPUT =~ $SAR_FORMAT_EN ]]; then
	echo "Hostname,Time AM/PM,runq-sz"
	sar -q | grep -v runq-sz | grep -e AM -e PM | awk -v sar_hostname="$SAR_HOSTNAME" 'BEGIN {OFS=","} {print sar_hostname,substr($1,1,length($1)-3)" "$2,$3}'
elif [[ $SAR_OUTPUT =~ $SAR_FORMAT_JA ]]; then
	echo "Hostname,Time AM/PM,runq-sz"
	sar -q | grep -v runq-sz | grep -e 秒 | awk -v sar_hostname="$SAR_HOSTNAME" 'BEGIN {OFS=","} {print sar_hostname,substr($1,1,length($1)-3),$2}'
else
	echo "sar format error"
fi

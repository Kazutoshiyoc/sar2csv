# sar2csv

## Quick start
Clone via HTTPS
```
git clone https://github.com/Kazutoshiyoc/sar2csv.git
```

Resolve dependency
```
dnf/apt install sysstat
systemctl enable sysstat
systemctl start sysstat
```

setup cron
```
crontab -e
	
	1-59/5 * * * * ~/sar2csv/exec.sh
```

#!/bin/bash
sed -i 's/DataBaseHost/'$DBHost'/g' /usr/local/zabbix/etc/zabbix_server.conf
sed -i 's/DataBaseName/'$DBName'/g' /usr/local/zabbix/etc/zabbix_server.conf
sed -i 's/DataBaseUser/'$DBUser'/g' /usr/local/zabbix/etc/zabbix_server.conf
sed -i 's/DataBasePass/'$DBPassword'/g' /usr/local/zabbix/etc/zabbix_server.conf
"/usr/local/zabbix/sbin/zabbix_server" "-f" "-c" "/usr/local/zabbix/etc/zabbix_server.conf"

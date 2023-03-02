#!/bin/bash
find /var/tmp/rear* -type d -ctime +1 -exec rm -rf {} \;
log_file=/var/log/rear/rear-devops-protein-12-84.log
echo "*********************************************************" > /tmp/output.txt
echo "devops-protein-12-84 Rear Backup successfully done"  >> /tmp/output.txt
echo "*********************************************************" >> /tmp/output.txt
echo "Starting devops-protein-12-84  rear backup at `date` ..........."  >> /tmp/output.txt

/usr/sbin/rear -v -d mkbackup #> /dev/null
if [ $? -eq 0 ];
then
echo "" >> /tmp/output.txt
echo "devops-protein-12-84 Rear Backup completed successfully  at `date`" >> /tmp/output.txt
echo "" >> /tmp/output.txt
echo "Backup distination : nfs://192.168.7.22/rear-backup "  >> /tmp/output.txt
#cat /tmp/output.txt |/usr/bin/s-nail -s "devops-protein-12-84  Rear Backup Successufly"   -S smtp-use-starttls -S ssl-verify=ignore -S smtp-auth=login  -S smtp=smtp://<MAIL-SRV>:25 -S from="<FROM-MAIL-ID>" -S smtp-auth-user=<SMTP-AUTH-MAIL-ID> -S smtp-auth-password=<PASSWORD> -S nss-config-dir=/etc/pki/nssdb/  <DESTINATION MAIL-ID>

cat /tmp/output.txt |/usr/bin/s-nail -s "devops-protein-12-84  Rear Backup Successufly done"   -S smtp-use-starttls -S ssl-verify=ignore -S smtp-auth=login  -S smtp=smtp://apmosys.icewarpcloud.in:587 -S from="admin@apmosys.com" -S smtp-auth-user=admin@apmosys.com -S smtp-auth-password='Ema!2022' -S nss-config-dir=/etc/pki/nssdb/  mohamed.rafik@apmosys.com
exit 1

else
echo "devops-protein-12-84  Rear Backup failed at `date`" >> /tmp/output.txt
echo   >> /tmp/output.txt
#echo   >> /tmp/output.txt
echo "************************************************************"  >> /tmp/output.txt
echo "Find below error log:"  >> /tmp/output.txt
#tail -n 100 /var/log/rear/rear-redmine.log  >> /tmp/output.txt
tail -n 100 $log_file >> /tmp/output.txt
#mail
#cat /tmp/output.txt |/usr/bin/s-nail -s "devops-protein-12-84  Rear Backup Failed"   -S smtp-use-starttls -S ssl-verify=ignore -S smtp-auth=login  -S smtp=smtp://<MAIL-SRV>:25 -S from="<FROM-MAIL-ID>" -S smtp-auth-user=<<SMTP-AUTH-MAIL-ID> -S smtp-auth-password=<PASSWORD> -S nss-config-dir=/etc/pki/nssdb/  <DESTINATION MAIL-ID>
cat /tmp/output.txt |/usr/bin/s-nail -s "devops-protein-12-84  Rear Backup Failed"   -S smtp-use-starttls -S ssl-verify=ignore -S smtp-auth=login  -S smtp=smtp://apmosys.icewarpcloud.in:587 -S from="admin@apmosys.com" -S smtp-auth-user=admin@apmosys.com -S smtp-auth-password='Ema!2022' -S nss-config-dir=/etc/pki/nssdb/  mohamed.rafik@apmosys.com

exit 1 # this code means OK

fi

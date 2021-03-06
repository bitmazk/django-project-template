#!/bin/bash
source $HOME/bin/script-settings.sh
BACKUPFOLDER=$LOCALE_BACKUP_FOLDER
mkdir -p $BACKUPFOLDER

KEEP=30
BACKUPS=`find $BACKUPFOLDER -name "locale-*.tgz" | wc -l | sed 's/\ //g'`
while [ $BACKUPS -ge $KEEP ]
do
ls -tr1 $BACKUPFOLDER/locale-*.gz | head -n 1 | xargs rm -f
BACKUPS=`expr $BACKUPS - 1`
done

DATE=`date +%Y%m%d%H%M%S`
rm -f $BACKUPFOLDER/.locale-${DATE}.tgz_INPROGRESS
tar -cvzpf $BACKUPFOLDER/.locale-${DATE}.tgz_INPROGRESS $DJANGO_APP_PATH/locale
mv -f $BACKUPFOLDER/.locale-${DATE}.tgz_INPROGRESS $BACKUPFOLDER/locale-${DATE}.tgz
exit 0

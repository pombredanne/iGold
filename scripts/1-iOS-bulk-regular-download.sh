#!/bin/bash

PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:home/Documents

export DISPLAY=:0.0

#so that cron can run in the correct directory

cd /Users/michael/Documents/

#error check - is iPhone available? 

testUpStatus=$(bagbak)

if [[ "$testUpStatus" == '' ]]; then
	echo "iPhone not connected - please connect it."
	dt=$(date '+%d/%m/%Y %H:%M:%S');
	echo "$dt - unable to run script as iPhone not connected " >> log.txt
	exit
	else
	
#mkdir

mkdir ios-apps

# run bag bak -l on all apps

bagbak -l >> export.lst

#from the list, grep out out just the names and then output to a transport list

grep -o "'.*'" export.lst |  sed -n " s,[^']*'\([^']*\).*,\1,p " >> all-current-apps.lst

#compare the transport list with the already downloaded list, and output only those not downloaded

downloaded=$(cat downloaded.lst)

filename1="all-current-apps.lst"
while read -r line; do
	appname="$line"
	
	if [[ "$downloaded" == *"$appname"* ]]; then
	echo "$appname already installed"
	dt=$(date '+%d/%m/%Y %H:%M:%S');
	echo "$dt - $appname - already installed " >> log.txt

	else 
	echo "$appname will be installed"
	echo "$appname" >> new-for-download.lst
	dt=$(date '+%d/%m/%Y %H:%M:%S');
	echo "$dt - $appname - added to download list " >> log.txt
	
fi
done < "$filename1"

#run download command for each new row/app in the download list and then update downloaded list

filename2="new-for-download.lst"
while read -r line; do
	newdownload="$line"
	echo "$newdownload"
	dt=$(date '+%d/%m/%Y %H:%M:%S');
	echo "$dt - started download - $newdownload " >> log.txt
	bagbak "$newdownload" -z --output ios-apps/
	dt=$(date '+%d/%m/%Y %H:%M:%S');
	echo "$dt - download complete - $newdownload " >> log.txt
	echo "$newdownload" >> downloaded.lst

done < "$filename2"

#delete operating files

rm export.lst
rm all-current-apps.lst
rm new-for-download.lst


fi
exit

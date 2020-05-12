#!/bin/bash

#get the aws buccket

echo "paste the s3 bucket url where the xml objects page is appearing"
read s3url

echo "set maximum total object count limit - type a number e.g. 50000"
read objectlimit

echo "set the number to iterate display of aws object per session - default to 1000" 
read iterateBy

namingconvention=0
countendpoint=0
lasturl1=""

mkdir -p s3bucket/{pages,index}

while [ "$max" = "" ] ; do

	#naming convention that is iteration relevant
	((namingconvention+=1))

	if [[ "$lasturl1" == "" ]]; then
			
		#export page
		wget "$s3url" --no-check-certificate -T 5 -t 1 -O s3bucket/pages/page"$namingconvention".xml

		else 
		#handle the first part of the loop
		startafter="&start-after=$lasturl1"

		#onlyused in second round
		additionalurl=("?list-type=2&max-keys=$iterateBy$startafter")

		#export page
		wget "$s3url""$additionalurl" --no-check-certificate -T 5 -t 1 -O s3bucket/pages/page"$namingconvention".xml

	fi

cat s3bucket/pages/page"$namingconvention".xml | sed 's/Key/\nKey/g' | grep '^Key' | grep -vE LastModified | grep -o -P '(?<=>).*(?=<)' | tail -n +4 >> s3bucket/index/endpointpage"$namingconvention".lst 

#get the last key and convert to variable for the next round. 
lasturl1=$(cat s3bucket/index/endpointpage"$namingconvention".lst | tail -1)

#Check status to confirm if max reached
totalIndex=$(cat s3bucket/index/* | wc -l | grep -Eo '^[^ ]+')
totalIndexFiltered=$(cat s3bucket/index/* | sort -u | wc -l | grep -Eo '^[^ ]+')

	if [[ "$totalIndexFiltered" < "$totalIndex" ]]; then
	
		echo "index complete"
		#EXPORT THE FINAL LIST OF ENDPOINTS
		cat s3bucket/index/* | sort -u >> s3bucket/total-endpoints.lst
		rm -r s3bucket/index 
		rm -r s3bucket/pages
		max="$totalIndexFiltered"

	fi

done

echo "review endpoints at s3bucket/total-endpoints.lst and then use the second script to download desirables"

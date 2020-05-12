#!/bin/bash

echo "please type the name of the folder to scan"

read folder

mkdir -p G-API-test/{maps,youtube,index}

echo "discover"

grep -Prao AIza[0-9A-Za-z-_]{35} "$folder" >> G-API-test/index/Google-keys.lst

cat G-API-test/index/Google-keys.lst | grep -Po AIza[0-9A-Za-z-_]{35} | sort -u >> G-API-test/index/purelist.lst

filename="G-API-test/index/purelist.lst"
while read -r line; do
	apikey=$line
	wget "https://maps.googleapis.com/maps/api/directions/json?origin=Toronto&destination=Montreal&key=""$apikey" --no-check-certificate  -P G-API-test/maps/ -T 5 -t 1
	wget "https://www.googleapis.com/youtube/v3/channels?part=brandingSettings,contentDetails,contentOwnerDetails,id,localizations,snippet,statistics,status,topicDetails&id=UCSrPxn-HV7nUdlN20ekPBcg&key=$apikey" --no-check-certificate  -P G-API-test/youtube/ -T 5 -t 1

done < $filename

echo "here are the map keys that worked:"

find G-API-test/maps/ -type f -size +15k

echo "here are the youtube keys that worked:"

find G-API-test/youtube/

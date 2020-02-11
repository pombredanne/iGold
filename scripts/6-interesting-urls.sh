#!/bin/bash

echo "Type folder to Grep"
read folder

mkdir -p grep-master-data/{index,scripts,db,download/{media,greppable}}

#build greppable list
echo -e '\.txt
\.html
\.htm
\.js' >> grep-master-data/db/greppable.lst

#build secrets list
echo -e 'token
secret
jwt
session
cookie
id=
key
deviceid
device_id
@
session
password
client_id
username
email
code
admin
credential
passwd
*@(([a-zA-Z](-?[a-zA-Z0-9])*)\.)+[a-zA-Z]{2,}*
hooks.slack.com' >> grep-master-data/db/secrets.lst

#build vulnerable links
echo -e 'eval
select' >> grep-master-data/db/vulnerable-links.lst

#build ip and port links
echo -e '*([0-9]{1,3}[\.]){3}[0-9]{1,3}*
:([1-5]?[0-9]{2,4}|6[1-4][0-9]{3}|65[1-4][0-9]{2}|655[1-2][0-9]|6553[1-5])' >> grep-master-data/db/ipandports.lst

#build storage list
echo -e 'amazonaws
googleusercontent
ftp
smb
docs.google.com
onedrive.live.com' >> grep-master-data/db/cloud-buckets.lst

#build media list
echo -e '\.doc
\.ppt
\.docx
\.pptx
\.exe
\.xls
\.xlsx
\.pdf
\.png
\.jpg
\.tgz
\.gz
\.mp4
\.mov' >> grep-master-data/db/mediafiletypes.lst

#build api list
echo -e "api
'*\/v1\/*'
'*\/v2\/*'
'*\/v3\/*'
'*\/v4\/*'
'*\/v5\/*'" >> grep-master-data/db/api.lst


grep -ir '.*http*.' "$folder" | sed 's/http/\nhttp/g' | grep '^http' | sed -ne "s/.*\(http[^' \"\)\#\<\>]*\).*/\1/p"  | grep '://' | sort -u >> grep-master-data/"$folder".urls

#List Media files
filename="grep-master-data/db/mediafiletypes.lst"
while read -r line; do
	filetype="$line"
	grep -i "$filetype" grep-master-data/"$folder".urls >> grep-master-data/index/mediafiles1.lst

done < "$filename"

cat grep-master-data/index/mediafiles1.lst | sort -u >> grep-master-data/index/mediafiles.lst
rm grep-master-data/index/mediafiles1.lst

#List API files
filename="grep-master-data/db/api.lst"
while read -r line; do
	apiurl="$line"
	grep -i "$apiurl" grep-master-data/"$folder".urls >> grep-master-data/index/api1.lst

done < "$filename"

cat grep-master-data/index/api1.lst | sort -u >> grep-master-data/index/api.lst
rm grep-master-data/index/api1.lst

#List greppable files
filename="grep-master-data/db/greppable.lst"
while read -r line; do
	filetype1="$line"
	grep -i "$filetype1" grep-master-data/"$folder".urls >> grep-master-data/index/greppable1.lst

done < "$filename"

cat grep-master-data/index/greppable1.lst | sort -u >> grep-master-data/index/greppable.lst
rm grep-master-data/index/greppable1.lst

#List urls containing secrets
filename="grep-master-data/db/secrets.lst"
while read -r line; do
	secret1="$line"
	grep -i "$secret1" grep-master-data/"$folder".urls >> grep-master-data/index/secrets1.lst

done < "$filename"

cat grep-master-data/index/secrets1.lst | sort -u >> grep-master-data/index/urlsecrets.lst
rm grep-master-data/index/secrets1.lst

#List urls containing vulnerable code
filename="grep-master-data/db/vulnerable-links.lst"
while read -r line; do
	vlnlnk="$line"
	grep -i "$vlnlnk" grep-master-data/"$folder".urls >> grep-master-data/index/vulnerable-links1.lst

done < "$filename"

cat grep-master-data/index/vulnerable-links1.lst | sort -u >> grep-master-data/index/vulnerable-links.lst
rm grep-master-data/index/vulnerable-links1.lst

#List urls containing cloud storage buckets
filename="grep-master-data/db/cloud-buckets.lst"
while read -r line; do
	cldstg="$line"
	grep -i "$cldstg" grep-master-data/"$folder".urls >> grep-master-data/index/cloud-buckets1.lst

done < "$filename"

cat grep-master-data/index/cloud-buckets1.lst | sort -u >> grep-master-data/index/cloud-buckets.lst
rm grep-master-data/index/cloud-buckets1.lst

#IP addresses and ports
filename="grep-master-data/db/ipandports.lst"
while read -r line; do

	iporport="$line"
	grep -i "$iporport" grep-master-data/"$folder".urls >> grep-master-data/index/ipandports1.lst

done < "$filename"

cat grep-master-data/index/ipandports1.lst | sort -u >> grep-master-data/index/ipandports.lst
rm grep-master-data/index/ipandports1.lst

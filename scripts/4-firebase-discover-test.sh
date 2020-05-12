#!/bin/bash

mkdir -p firebase-test-data/{authenticated/scripts,unauthenticated}

echo "Type folder to search:"
read folder1

#unauthenticated testing
echo "UNAUTHENTICATED TESTING STARTED"

grep -r -i -a -I "firebaseio.com" "$folder1" | sed -ne 's/.*\(http[^<]*\).*/\1/p' | sed -ne 's/.*\(http[^"]*\).*/\1/p' | sed -ne "s/.*\(http[^']*\).*/\1/p" | sort -u >> firebase-test-data/unauthenticated/firebase-urls.lst

filename="firebase-test-data/unauthenticated/firebase-urls.lst"
while read -r line; do
	neturl="$line"
	req0="$neturl/.json?shallow=true" 
	echo "$req0" >> firebase-test-data/unauthenticated/firebase-output.txt
	echo "$req0"
	request1=$(curl -g "$req0") 
	echo "$request1" >> firebase-test-data/unauthenticated/firebase-output.txt
	echo "$request1" 
    
done < "$filename"

#authed testing

grep -Ril firebaseio.com "$folder1" >> firebase-test-data/authenticated/index-files.lst

touch firebase-test-data/authenticated/validate.lst

filename="firebase-test-data/authenticated/index-files.lst"
while read -r line; do
	neturl="$line"
	scriptname="${neturl////-}" 
	API_KEY=$(grep -ir -A 1 API_KEY "$neturl" | tail -n +2 | grep -o -P '(?<=>).*(?=<)')
	#echo "$API_KEY"
	DATABASE_URL=$(grep -ir -A 1 DATABASE_URL "$neturl" | tail -n +2 | grep -o -P '(?<=>).*(?=<)')
	#echo "$DATABASE_URL"
	STORAGE_BUCKET=$(grep -ir -A 1 STORAGE_BUCKET "$neturl" | tail -n +2 | grep -o -P '(?<=>).*(?=<)')
	#echo "$STORAGE_BUCKET"
	authDomain=$(echo $STORAGE_BUCKET | cut -d. -f1)


#test if already discovered or now

STR=$(cat firebase-test-data/authenticated/validate.lst)
SUB="$authDomain"
if [[ "$STR" == *"$SUB"* ]]; then
  		
	echo "Duplicate - skipping"

	else 
	echo "New - creating"
	echo -e "import pyrebase\n
config = {
  'apiKey': '$API_KEY',
  'authDomain': '$authDomain.firebaseapp.com',
  'databaseURL': '$DATABASE_URL',
  'storageBucket': '$STORAGE_BUCKET',
}\n
firebase = pyrebase.initialize_app(config)\n
db = firebase.database()\n
print(db.get())" >> "firebase-test-data/authenticated/scripts/$authDomain.py"

echo "$authDomain" >> firebase-test-data/authenticated/validate.lst

	fi

done < "$filename"

cd firebase-test-data/authenticated/scripts

find . >> ../index-scripts.lst

filename="../index-scripts.lst"
while read -r line; do
	pythonscript="$line"
	echo "$pythonscript"
	python3 "$pythonscript"

done < "$filename"

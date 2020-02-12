echo "enter the folder you wish to scan"
read folder
find "$folder" -name Info.plist -exec grep -o -P '(?<=key>).*(?=<)' {} \; | grep '\.' | sort -u

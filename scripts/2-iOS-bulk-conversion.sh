#!/bin/bash

#this script finds and converts the following to greppable format: plist files (xml), binaries (strings), executables (class dumping)

fontbold=$(tput bold)
fontnormal=$(tput sgr0)
tn=8
dc=1

echo -e "\n    Start by typing the name of the folder you wish to scan.\n"
read folder

echo ""
######################################
echo -e "   ${fontbold}[$dc/$tn]${fontnormal} Building working directories			STARTED"

mkdir -p "$folder"-audit/{index,output,scan/{executable,binaries,plist,other}}

echo -e "                                    			COMPLETED\n"
######################################
((dc++))
echo -e "   ${fontbold}[$dc/$tn]${fontnormal} Indexing extracted iOS app directory		STARTED" 

#find all plist files
find "$folder" -name '*plist' >> "$folder"-audit/index/plist-files.lst
#find all binaries
find "$folder" -type f -exec file -i '{}' \; | grep 'charset=binary' | grep -vE "(.plist|.png|.gz|.ttf)" | cut -f1 -d":" >> "$folder"-audit/index/binaries.lst
#find all executables
find "$folder" -type f -exec file -i '{}' \; | grep 'application/x-mach-binary' | cut -f1 -d":"  >> "$folder"-audit/index/executables.lst
#find everything else
find "$folder" -type f -exec file -i '{}' \; | grep -vE "(.png|.gz|.ttf|x-mach-binary|charset=binary)" | cut -f1 -d":" >> "$folder"-audit/index/other.lst
#find signatures
find signatures -type f >> "$folder"-audit/index/signatures.lst

echo -e "                                    			COMPLETED\n"
######################################
((dc++))
echo -e "   ${fontbold}[$dc/$tn]${fontnormal} Plists conversion				STARTED" 


filename="$folder-audit/index/plist-files.lst"
while read -r line; do
	plistfile="$line"
	individualplistname="${plistfile////-}" 
	individualplistname+=".xml"
	plistutil -i "$plistfile" -o "$folder-audit/scan/plist/$individualplistname"
     
done < "$filename"


echo -e "                                    			COMPLETED \n"
######################################
((dc++))
echo -e "   ${fontbold}[$dc/$tn]${fontnormal} Binary scan					STARTED" 


filename="$folder-audit/index/binaries.lst"
while read -r line; do
	binarylocation="$line"
	individualbinaryname="${binarylocation////-}" 
	strings "$binarylocation" >> "$folder-audit/scan/binaries/$individualbinaryname"
     
done < "$filename"


echo -e "                                    			COMPLETED\n"
######################################
((dc++))
echo -e "   ${fontbold}[$dc/$tn]${fontnormal} Class-dump on executable			STARTED" 


filename="$folder-audit/index/executables.lst"
while read -r line; do
	execlocation="$line"
	individualexecname="${execlocation////-}" 

	jtool.ELF64 -arch arm -d objc -v "$execlocation" >> "$folder-audit/scan/executable/$individualexecname"
     
done < "$filename"


echo -e "                                    			COMPLETED\n"

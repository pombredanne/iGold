#!/bin/bash

#requirements - class-dump

fontbold=$(tput bold)
fontnormal=$(tput sgr0)
tn=8
dc=1

echo "    _  ___  ____   ____                     _ _ _   "
echo "   (_)/ _ \/ ___| / ___|_ __ __ _ _   _  __| (_) |_ "
echo "   | | | | \___ \| |  _| '__/ _\` | | | |/ _\` | | __|"
echo "   | | |_| |___) | |_| | | | (_| | |_| | (_| | | |_ "
echo "   |_|\___/|____/ \____|_|  \__,_|\__,_|\__,_|_|\__|"
echo "                                                    "
echo "   iOS APP AUDIT TOOL "

echo -e "\n   Welcome to the iOS app code review tool"
echo -e "   After using a tool like Bagbak .ipa extraction to decrypt and extract an iOS app,"
echo -e "   the app folder can then be copied to your computer. iOSGraudit will then scan"
echo -e "   nominated folder for any secrets or vulnerable code.\n"
echo -e "   To make this even more effective, before running this tool, input any known"
echo -e "   unique strings associated with the target (ie. cookie ID's) into the unique string"
echo -e "   list 'signatures\uniquestrings.lst'\n"

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

find "$folder" -name '*plist' >> "$folder"-audit/index/plist-files.lst
find "$folder" -type f -exec file -i '{}' \; | grep 'charset=binary' | grep -vE "(.plist|.png|.gz|.ttf)" | cut -f1 -d":" >> "$folder"-audit/index/binaries.lst
find "$folder" -type f -exec file -i '{}' \; | grep 'application/x-mach-binary' | cut -f1 -d":"  >> "$folder"-audit/index/executables.lst
find "$folder" -type f -exec file -i '{}' \; | grep -vE "(.png|.gz|.ttf|x-mach-binary|charset=binary)" | cut -f1 -d":" >> "$folder"-audit/index/other.lst
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

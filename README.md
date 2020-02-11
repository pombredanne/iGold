# iGold - finding Gold in iOS app's

A collection of scripts used to workflow/automate the download and discovery of bounty leads in iOS apps, en masse. 

>**Use case 1:** During the day, if I see a new bounty program, I can download the iOS app onto my phone which automatically triggers a process at home to download, decompile the app, test database connections, etc. all while I'm out during the day. 

>**Use case 2:** Download hundreds of apps from various bounty platform's. As they are downloaded, they are automatically decompiled and tested, en masse. 


Obviously don't use these scripts on assets which you are not authorised to test. 

There is a number of pre-requisite tools that needs to be installed first, [here](https://github.com/SherlocksHat/iGold/blob/master/install.sh). 

## 1. Bulk download iOS app's

* Script: [download iOS apps in bulk](https://github.com/SherlocksHat/iGold/blob/master/scripts/1-iOS-bulk-regular-download.sh)
  This script is designed to:
  * run on Mac OS.
  * run as a crontab so that all you need to do is install an app on your iPhone and the rest is taken care off. 
 
  Pre-req's; a jailbroken iPhone which connects to your Mac via proxied ssh.
     
## 2. Extraction and decompiling app data

 * Bulk conversion of iOS apps to greppable formats (ie. class dumping, plist conversion) - [decompile/extract iOS app data](https://github.com/SherlocksHat/iGold/blob/master/scripts/2-iOS-bulk-conversion.sh)
 
## 3. Get linked files

 * grep and wget urls from extracted app files (greppable files like .js, flash, .zip, .gz, docx) 
 
 * Decompile flash files - (install: sudo apt-get install swfmill) (run: swfmill swf2xml movie.swf movie.xml)

## 4. Discover secrets

 * Discovery of secrets, vulnerable code and lucrative endpoints - [secrets-discovery](https://github.com/SherlocksHat/iGold/blob/master/scripts/6-interesting-urls.sh)

 * Detect-secrets audit using regex detection (review Yelps regex for signatures and add to the discovery point above)
 
 ## 5. Automatic testing
 * Automatic discovery and testing of Firebase databases - [Firebase discovery and test](https://github.com/SherlocksHat/iGold/blob/master/scripts/3-firebase-discover-test.sh)
  
 * Discovery and download of s3 bucket objects (an alternative to aws cli-tools when cli doesn't do what you want. [SherlocksHat-cli tools](https://github.com/SherlocksHat/iGold/blob/master/scripts/5-s3-bucket-list-objects.sh). 
 
 * Run URLs through otxurls and waybackurls and spider them?

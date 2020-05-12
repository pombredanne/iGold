# iGold - finding Gold in iOS app's

A work-in-progress collection of scripts used to workflow/automate the download and discovery of bounty leads in iOS apps, en masse. 

>**Use case 1:** During the day, if I see a new bounty program, I can download the iOS app onto my phone which automatically triggers a process at home to download, decompile the app, test database connections, etc. all while I'm out during the day. 

>**Use case 2:** Download hundreds of apps from various bounty platform's. As they are downloaded, they are automatically decompiled and tested, en masse. 

Obviously don't use these scripts on assets which you are not authorised to test. 

There is a number of pre-requisite tools that needs to be installed first, [here](https://github.com/SherlocksHat/iGold/blob/master/install.sh). 

## 1. Bulk download of iOS app's

* Script: [download iOS apps in bulk](https://github.com/SherlocksHat/iGold/blob/master/scripts/1-iOS-bulk-regular-download.sh)
  This script is designed to:
  * run on Mac OS.
  * run as a crontab so that all you need to do is install an app on your iPhone and the rest is taken care off. 
 
  Pre-req's; a jailbroken iPhone which connects to your Mac via proxied ssh.
     
## 2. Extraction and decompiling app data

 * Bulk conversion of iOS apps to greppable formats (ie. class dumping, plist conversion) - [decompile/extract iOS app data](https://github.com/SherlocksHat/iGold/blob/master/scripts/2-iOS-bulk-conversion.sh)
 
## 3. Get URL secrets

 * Oftern urls within app binaries can unwittlingly contain tokens or secrets. This script with grep urls from extracted app files, and highlight URLS worth investgiating further.  [discover and download more greppable data](https://github.com/SherlocksHat/iGold/blob/master/scripts/3-url-secrets.sh)
 * list ATS domain exceptions for further analysis (see ATS exceptions in the OWASP MSTG for more info) - [list-ATS-domain-exceptions.sh](https://github.com/SherlocksHat/iGold/blob/master/scripts/7-list-ATS-domain-exceptions.sh)
 
 ## 5. Automatic testing
 * Automatic discovery and testing of Firebase databases - [firebase discovery and test](https://github.com/SherlocksHat/iGold/blob/master/scripts/4-firebase-discover-test.sh)
 * Automatic discovery and testing of Youtube and Google Maps API keys. [Youtube & Maps API discovery and test] (https://github.com/SherlocksHat/iGold/blob/master/scripts/5-test-google-apis.sh)
  
  ## 6. Other helpful hacks
 * Search list and display all plist files [plist file display] (https://github.com/SherlocksHat/iGold/blob/master/scripts/8-search-plist-files.sh).
 * List of API Key regex to search through mobile apps for [api key regex] (https://github.com/SherlocksHat/iGold/blob/master/scripts/key-regex.lst)

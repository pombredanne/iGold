# iGold - finding Gold in iOS app's
A collection of scripts used to workflow/automate the download and discovery of bounty leads in iOS apps, en-mass. 

Obviously don't use these scripts on assets which you are not authorised to test. 

There is a number of pre-requisite tools that needs to be installed first, [here](https://github.com/SherlocksHat/iGold/blob/master/install.sh). 

## 1. Bulk download iOS app's

Script: [download iOS apps in bulk](https://github.com/SherlocksHat/iGold/blob/master/scripts/1-iOS-bulk-regular-download.sh)
  * This script is designed to
    * run on Mac OS.
    * run as a crontab so that all you need to do is install an app on your iPhone and the rest is taken care off. 
   * Pre-req's; 
     * jailbroken iPhone which connects to your Mac via proxied ssh.
     
## 2. Extraction and decompiling app data

#### (a) bulk conversion of iOS apps to greppable formats (ie. class dumping, plist conversion)
  [convert to readable format](https://github.com/SherlocksHat/iGold/blob/master/scripts/2-iOS-bulk-conversion.sh)
 
#### (b) automatic discovery and testing of Firebase databases. 
  [Firebase discovery and test](https://github.com/SherlocksHat/iGold/blob/master/scripts/3-firebase-discover-test.sh)
  
#### (c) discovery and download of s3 bucket objects. (alternative to cli-tools)
  [SherlocksHat-cli tools](https://github.com/SherlocksHat/iGold/blob/master/scripts/5-s3-bucket-list-objects.sh). This is an alternative to aws cli-tools when cli doesn't do what you want. 
  
#### (d) decompile and search flash files
sudo apt-get install swfmill
swfmill swf2xml movie.swf movie.xml

## 3. Discovery of secrets and vulnerable code

#### (a) discovery of secrets and lucrative endpoints. 
  [secrets-discovery](https://github.com/SherlocksHat/iGold/blob/master/scripts/6-interesting-urls.sh)
  
#### (b) Detect-secrets audit using regex detection
  yelps detect secrets

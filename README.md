# iGold - finding Gold in iOS app's
A collection of scripts used to workflow/automate the download and discovery of bounty leads in iOS apps, en-mass. 

#### 1. Automated bulk download of iOS apps
  [Download bulk ios apps](https://github.com/SherlocksHat/bulk-download-ios-apps)
  * This script is designed to
    * run on Mac OS.
    * run as a crontab so that all you need to do is install an app on your iPhone and the rest is taken care off. 
#### 2. Bulk conversion of iOS apps to readable formats (ie. class dumping, plist conversion)
  [Convert to readable format](https://github.com/SherlocksHat/iOSGraudit)
#### 3. Automatic discovery and testing of firebase databases. 
  [Firebase discovery and test](https://github.com/SherlocksHat/firebase-search-connect)
#### 4. Automatic discovery and spidering of embedded urls, including APIs, media files and more. 
  [Asset-Discovery](https://github.com/SherlocksHat/iOS-grep-master)
#### 5. Identify and test access to cloud buckets 
  [Test access to aws buckets](https://github.com/SherlocksHat/aws-s3-objects-test/)
  or just use aws-cli - https://github.com/swisskyrepo/PayloadsAllTheThings/tree/master/AWS%20Amazon%20Bucket%20S3
#### 6. Detect-secrets audit using regex detection
  TBC
#### 7. decompile and search flash files
sudo apt-get install swfmill
swfmill swf2xml movie.swf movie.xml

#### 8. interacting with Slack hooks
curl -X POST https://hooks.slack.com/services/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 -H "Content-type: application/json" --data "{'text': 'Please note this hash: 56446d168792f442211c31390348f0d2'}"


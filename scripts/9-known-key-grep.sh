#!/bin/bash

mkdir keyscan

echo "Algolia
Asana
AWS
Bit.ly
Branch.io
Buildkite
CircleCI
DataDog
Deviant Art
Dropbox API
Facebook
Firebase
FreshDesk
Github
Gitlab
Google Cloud Messaging
GCM
Google Maps
Recaptcha
Heroku
Instagram
JumpCloud
MailChimp
MailGun
Mapbox
Microsoft Azure
Microsoft Shared Access Signatures
SAS
pagerduty
Paypal
Pendo
Razorpay
Salesforce
SauceLabs
SendGrid
Slack
Slack
Spotify
Square
Stripe Live
Travis CI
Twilio
Twitter
WakaTime
WPEngine
Zapier
Zendesk
Hubspot" >> keyscan/key-index.lst

echo "type folder to scan"
read folder

filename="keyscan/key-index.lst"

while read -r line; do

	key="$line"

	echo "Searching for $key assets"
	grep -ir -I -B 1 -A 5 "$key" "$folder" | grep -Eo '.{10}(api|key|secret|token|password).{100}' | grep -E '(api|key|secret|token|password)' --color=always >> keyscan/"$key"-scan.lst

done < "$filename"

#maybe use detect secrets on the output as this is still very noisy. 

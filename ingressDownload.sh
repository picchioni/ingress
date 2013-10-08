#!/bin/bash

#Install IOS-Ingress via direct download on your device
#Hacked together by Garret Picchioni
#Requires jailbroken device with wget, AppCake, and a way to execute this script (via terminal or SSH)
#Should be executed as mobile user, but will compensate if ran by root
#Script can be placed anywhere but /var/mobile is suggested

downloadsFolder="/var/mobile/Documents/Downloads/"
ingressIPA="${downloadsFolder}Ingress.ipa"
remoteLocation="http://www.ios-ingress.com/downloads/Ingress.ipa"

echo "Checking if wget is installed"
wgetCheck=`type -P wget`
if [[ -z $wgetCheck ]]; then
	echo "wget is not installed, please install via Cydia"
	exit 1
fi

if [[ ! -d $downloadsFolder ]]; then
	echo "$downloadsFolder does not exist, please confirm AppCake is installed"
fi

if [[ -f $ingressIPA ]]; then
	echo "Removing old Ingress IPA file"
	rm $ingressIPA
fi

echo "Downloading Ingress"
wget -P $downloadsFolder $remoteLocation

user=`whoami`
if [[ $user != "mobile" ]]; then
	echo "Setting proper permissions for the IPA"
	chown mobile $ingressIPA
fi

echo "Done! Install IPA from AppCake"

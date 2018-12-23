#!/bin/bash
#This script resets the receiver when using NRF24 module. Make sure to compile usbreset.c first.
USBNAME=Nordic
LSUSB=$(lsusb | grep --ignore-case $USBNAME)
FOLD="/dev/bus/usb/"$(echo $LSUSB | cut --delimiter=' ' --fields='2')"/"$(echo $LSUSB | cut --delimiter=' ' --fields='4' | tr --delete ":")
echo $LSUSB
echo $FOLD
sudo /usr/bin/usbreset $FOLD

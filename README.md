# pizero
A tiny pen-testing tool kit for Pi Zero W

## Scripts
### btserial.sh
One time configuration to set up a terminal shell over bluetooth. This is especially useful when setting the on-board wifi chip into monitor mode. Read the comments at the top for an important note. In the future this will be cleaner.

### usbreset.c
C code that resets a USB device. For our purposes it works without having to reboot.  
Source: https://marc.info/?l=linux-usb&m=121459435621262&w=2

### reset-usb.sh
A simple shell script that resets a device by name. You can find the device name by doing **lsusb**.

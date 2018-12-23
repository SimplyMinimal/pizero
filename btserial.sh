#!/bin/bash -e

#This script will set up your pi to allow a terminal shell over Bluetooth
#Use an app like Serial Bluetooth Terminal to connect to the shell
#Remember to change piscan to noscan after you run this script and connect

#Edit the display name of the RaspberryPi so you can distinguish
#your unit from others in the Bluetooth console
echo PRETTY_HOSTNAME=raspberrypi > /etc/machine-info

# Edit /lib/systemd/system/bluetooth.service to enable BT services
# After this script executes, go ahead and change piscan to noscan to disable broadcast
sudo sed -i: 's|^Exec.*toothd$| \
	ExecStart=/usr/lib/bluetooth/bluetoothd -C \
	ExecStartPost=/usr/bin/sdptool add SP \
	ExecStartPost=/bin/hciconfig hci0 piscan \
	|g' /lib/systemd/system/bluetooth.service

# create /etc/systemd/system/rfcomm.service to enable
# the Bluetooth serial port from systemctl
sudo cat <<EOF | sudo tee /etc/systemd/system/rfcomm.service > /dev/null
[Unit]
Description=RFCOMM service
After=bluetooth.service
Requires=bluetooth.service

[Service]
ExecStart=/usr/bin/rfcomm watch hci0 1 getty rfcomm0 115200 vt100 -a pi

[Install]
WantedBy=multi-user.target
EOF

# enable the new rfcomm service
sudo systemctl enable rfcomm

# start the rfcomm service
sudo systemctl restart rfcomm


# We are done
# To connect first do the following on the client machine:
# ls /dev/cu.*
# Find the one named after your pi. Assume it is called raspberrypi.
# To connect do:
# screen /dev/cu.raspberrypi-SerialPort 115200

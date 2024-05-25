#!/bin/sh

sed -i 's/^tty1/#tty1/' /etc/inittab
sed -i 's/^tty2/#tty2/' /etc/inittab
sed -i 's/^tty3/#tty3/' /etc/inittab
sed -i 's/^tty4/#tty4/' /etc/inittab
sed -i 's/^tty5/#tty5/' /etc/inittab
sed -i 's/^tty6/#tty6/' /etc/inittab
sed -i 's/^#ttyS0/ttyS0/' /etc/inittab
sed -i 's/^ttyS0.*/ttyS0::respawn:\/sbin\/agetty -L 115200 ttyS0 linux --noclear/' /etc/inittab

cp /boot/boot.sd-* /boot/boot.sd

# enable blinking led when system has booted
ln -s /etc/init.d/blink /etc/runlevels/default/blink

# enable rndis usb networking by default
ln -s /etc/init.d/usb-rndis /etc/runlevels/default/usb-rndis

# on those small systems it is faster to delete the packages later
# if not needed than to install them if needed, so lets install the
# build tools by default
/scripts/install-buildtools.sh

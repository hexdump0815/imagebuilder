IMPORTANT: the branches have been renamed - the old master branch is now called legacy, the old dev branch dev-old and the old experimental branch is now the main branch

# introduction

this is a simple framework for building bootable sd card images for various (currently arm based) small computer like devices. it is supposed to run natively, i.e. if you want to build an image for a 32bit arm system you should run it on a 32bit arm system and so on. i started it when i wanted to easily and reproducably build bootable sd card images for some arm devices for which there are no such images with recent distributions and linux kernels available or do not exist at all. i'm aware of the armbian (https://www.armbian.com/) framework, which has a similar goals and is much more advanced, but i wanted something simpler so that i can easier adjust it for prototyping and i wanted to build everything natively as i do not really have any string intel machine for cross compiling. if anyone with amrbian knowledge and a proper build environment is interested to port over the patches etc. for the few yet armbian unsupported systems over to armbian that would be more than welcome.

please keep in mind that the intention of those images is to make it easier to get started on not too well supported systems or setups. they are not intended as a fully end user ready distribution - some fine tuning and adjustment (a bit less on ubuntu and a bit more on debian) will most probably be required still to make them fully working, but at least you do not have to think about how to get this device booting or where to get a working kernel from etc. ...

# creating images

see scripts/README.md as a start

more coming soon ...

# using the images

simply write/flash (not just copy!) the images to an sd card - there is a lot of documentation about how to do this on the web. the images require an sd card of at least 8gb size - more is no problem and can be made useable after the first boot of the image.

the images provided are ubuntu 18.04 lts (bionic) with the xubuntu desktop environment and debian 10 (buster) with the xfce desktop environment. both images are supporting gles via mali drivers/blobs and opengl via gl4es (https://github.com/ptitSeb/gl4es). they have a user named "linux" configured with the password "changeme" and sudo permission (use "sudo -i" to get root). the hostname is set to "changeme". they are assuming a us keyboard and are setup for english, so one should configure it as needed after the first boot - a good start might be:

* locale: dpkg-reconfigure locales
* timezone: dpkg-reconfigure tzdata
* console keyboard (run this on the console if needed at all): dpkg-reconfigure keyboard-configuration
* console (run this on the console if needed at all): dpkg-reconfigure console-setup

or even simpler, just use the various graphical settings tools installed.

some commands to set the keyboardmapping in an x terminal:

* english: setxkbmap us
* french: setxkbmap fr
* german: setxkbmap de
* italian: setxkbmap it
* portuguese: setxkbmap pt
* russian: setxkbmap ru
* spanish: setxkbmap es
* ...
* onscreen keyboard: apt-get install matchbox-keyboard ; matchbox-keyboard
      alternatively: apt-get install onboard ; onboard
* for console: loadkeys us (etc. like above)

to use all the space on your sd card, please run the following command as root after the first boot: "/root/extend-rootfs.sh"

the mali driver is disabled by default, as it results in unstable behaviour on some systems. it can easily enabled by commenting out (via # in front of the line) the blacklist line in /etc/modprobe.d/blacklist-mali*.conf or alternatively simply loaded via "modprobe maligpu", "modprobe mali" or "modprobe mali_kbase" depending on the name of the mali kernel module on a certain system.

to install basic development tools simply run "apt-get install build-essential"

to get rid of libreoffice for instance simply run "apt-get remove libreoffice ; apt-get auto-remove"

more coming soon ...

# system specific information

* odroid u2, u3, u3+, x and x2
  * for the odroid x2 the file extlinux/extlinux.conf in the first partition needs to be edited - see the comments in the file
  * for the odroid x the file extlinux/extlinux.conf in the first partition needs to be edited - see the comments in the file
  * the display resolution is set to 1024x768 by default in the same file and can be changed there if needed
  * a fixed ether mac address is set in the same file and can be changed if multiple such devices are running in the same network or omitted to get a new random ethernet mac address on each boot
  * enabling the mali driver at least for me sometimes results in unstable booting (hanging or mali not detected properly), rebooting (same symptoms), other times it works just fine, unplugging theboard from power for a few minutes usually helps - without the mali driver enabled the problems go away
  * see https://github.com/hexdump0815/linux-mainline-and-mali-on-odroid-u3 for some more information

* orbsmart s92 / beelink r89 tv boxes
  * info coming soon ...

* amlogic s905/s905x/s905w tv boxes (with 64bit kernel plus 64bit or 32bit userland)
  * info coming soon ...

* samsung snow chromebook rev4 and rev5 (XE303C12)
  * for the rev5 samsung snow chromebook the file extlinux/extlinux.conf in the second partition needs to be edited (otherwise audio will not work properly) - see the comments in the file
  * the mali driver seems to work, load and unload quite reliable
  * some good information on how to enable developer mode (required) and how to boot the chromebook from the sd card can be found here: https://archlinuxarm.org/platforms/armv7/samsung/samsung-chromebook
  * see https://github.com/hexdump0815/linux-mainline-and-mali-on-samsung-snow-chromebook for some more information

* rockchip based veyron chromebooks (medion s2013, medion s2015, acer c201 and some others)
  * info coming soon ...

* tegra based nyan big chromebook (acer cb5 311)
  * info coming soon ...

* raspberrypi 3 and 4 64bit images
  * info coming soon ...

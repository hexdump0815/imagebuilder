# getting started using the images

simply write/flash (not just copy!) the images to an sd card - there is a lot
of documentation about how to do this on the web. the images require an sd
card of at least 8gb size (for the newer images even 4gb sould be enough) -
more is no problem and can be made useable after the first boot of the image
using the /scripts/extend-rootfs.sh script.

the default username/password to login is: linux/changeme

use "sudo -i" to get root if needed. the hostname is set by default to
"changeme". the images are assuming a us keyboard and are setup for english,
so one should configure it as needed after the first boot using the
/scripts/initial-setup.sh script - this will setup the keyboard, timezone and
locale. sometimes the keyboard setup is skipped, then it can be adjusted in
the file /etc/default/keyboard.

some commands to set the initial keyboard mapping in an x terminal to run
anything with the proper keyboard layout before everything is setup properly:

* english: setxkbmap us
* french: setxkbmap fr
* german: setxkbmap de
* italian: setxkbmap it
* portuguese: setxkbmap pt
* russian: setxkbmap ru
* spanish: setxkbmap es
* ...

there is an onscreen keyboard available via top menu on the login screen and
the onboard onscreen keyboard is available in the xfce session (the four
little squares in right part of the menubar).

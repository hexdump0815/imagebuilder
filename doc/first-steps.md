# getting started using the images

simply write/flash (not just copy!) the images to an sd card - there is a lot
of documentation about how to do this on the web. the images require an sd
card of at least 8gb size (for the newer images even 4gb sould be enough) -
more is no problem and can be made useable after the first boot of the image
using the /scripts/extend-rootfs.sh script.

the default username/password to login is: linux/changeme

all images from november 2023 on will have the /scripts/desktop-to-server.sh
to remove the ui, xorg, desktop etc. packages from the system in case it is
intended for a more server type usage scenario where the removed packages
would just increase the bloat and decrease the security of the system. for
older images the commands in this script can be run manually - see:
https://github.com/hexdump0815/imagebuilder/blob/main/files/extra-files-bookworm/scripts/desktop-to-server.sh
and
https://github.com/hexdump0815/imagebuilder/blob/main/files/extra-files-jammy/scripts/desktop-to-server.sh
depending on the image in use.

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

it might be worth to have a look at the doc folder for other documents which
might be of interest and also some systems have a doc dir with system specific
information in their system directory.

another good source of information are the already existing github issues of
this repository as quite a few topics and problems were discussed there
already. the top level search of github restricted to "this repository" or
the search box of the issues (best searching across open and closed issues)
seem to work well for searching what is there.

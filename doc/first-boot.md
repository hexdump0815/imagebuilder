# After first boot

the images are assuming a us keyboard and are setup for english, so one should configure it as needed after the first boot using the ```/scripts/initial-setup.sh``` script - this will setup the keyboard, timezone and locale. sometimes the keyboard setup is skipped, then it can be adjusted in the file /etc/default/keyboard.

some commands to set the initial keyboard mapping in an x terminal to run anything with the proper keyboard layout before everything is setup properly:

```
english: setxkbmap us
french: setxkbmap fr
german: setxkbmap de
italian: setxkbmap it
portuguese: setxkbmap pt
polish: setxkbmap pl
russian: setxkbmap ru
spanish: setxkbmap es
...
```

you might be interested in running ```/scripts/extend-rootfs.sh``` which will extend the rootfs to the end of the disk

additional setup instructions can be found [here](./postinst/readme.md)
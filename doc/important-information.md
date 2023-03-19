# important last minute information regarding the images

this is a list of last minute errata and other important information around
the images starting with the newest ones first.

## 23-04-03 file ownerships can be wrong on aarch64 images

due to some messed up permissions on my image build system aarch64 images
from before beginning of march 2023 might come with wrong file and directory
ownerships. to check if an installation is affected and fix the problem in
case it is please run the following commands:
```
# show all affected files
find /bin /boot /etc /lib /opt /root /sbin /scripts /usr -user linux -ls
# remove the group writable flag for them
find /bin /boot /etc /lib /opt /root /sbin /scripts /usr -user linux -exec chmod g-w {} \;
# fix the ownership for them
find /bin /boot /etc /lib /opt /root /sbin /scripts /usr -user linux -exec chown root:root {} \;
# fix also the symlinks
find /bin /boot /etc /lib /opt /root /sbin /scripts /usr -user linux -type l -exec chown -h root:root {} \;
# check again - nothing should be left
find /bin /boot /etc /lib /opt /root /sbin /scripts /usr -user linux -ls
```
thanks a lot to @shelterx for pointing this out - see:
https://github.com/hexdump0815/linux-mainline-on-arm-chromebooks/issues/1#issuecomment-1454750777

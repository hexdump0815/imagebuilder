# important last minute information regarding the images

this is a list of last minute errata and other important information around
the images starting with the newest ones first.

## 24-09-16 trogdor ubuntu images are missing wifi connectivity on some systems

see
https://github.com/hexdump0815/imagebuilder/issues/231#issuecomment-2212464410
and
https://github.com/hexdump0815/imagebuilder/issues/44#issuecomment-2352929478
to hopefully get this fixed - future images will hopefully have this fixed

## 23-09-25 cgpt seems to be broken on 32bit armv7l systems in debian bookworm

it was reported a few months ago already here:
https://github.com/hexdump0815/imagebuilder/issues/144 but today i ran into it
myself as well: it looks like the debian bookworm cgpt package (required for
creating chromebook style partitions) seems to be broken on the 32bit armv7l
platform (it seems to still work well on the 64bit aarch64 systems). i or
someone else should report this as a bug to debian, but in the meantime the
following should be useable as a workaround (as already pointed out in the
mentioned github issue):
```
wget http://ftp.debian.org/debian/pool/main/v/vboot-utils/cgpt_0~R88-13597.B-1_armhf.deb
dpkg -i cgpt_0~R88-13597.B-1_armhf.deb
```
this will install the bullseye (latest debian stable version before bookworm)
version of cgpt, which is working fine.

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
# fix /
chmod g-w /
chown root:root /
```
thanks a lot to @shelterx for pointing this out - see:
https://github.com/hexdump0815/linux-mainline-on-arm-chromebooks/issues/1#issuecomment-1454750777

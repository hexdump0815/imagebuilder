# these notes describe the steps required to get from debian stable to debian
testing

## introduction

TODO: recheck and update if still relevant for newer debian and ubuntu versions

currently debian stable is bullseye and debian testing is bookworm, so to go
from the first to the second is described here. the motivation for going this
way might be to have more up to date software packages. when thinking about
this, please keep in mind that going back from testing to stable is not easily
possible, so better do a backup of the old system beforehand. before starting,
please make sure that enough free disk space is available as nearly all
packages will get downloaded and reinstalled. one other thing to keep in mind
is that debian testing is not considered to be as stable as debian stable (as
the names might imply), so better do not use it for productive systems and be
prepared that it might break from time to time, although i think it actually
is quite stable. one side effect of using testing instead of stable is that
packages get updated more frequently. i guess the same procedure can then most
probably also be used to go from testing to unstable (debian sid).

## preparations

as the mesa version coming with testing is very close to the latest mesa
version available it is not really required to use the self build mesa in most
cases and the following commands can be used to switch back to the default
mesa before doing the upgrade:
```
# to get the latest versions of the default debian mesa after the apt unhold
# for armv7l (32bit arm)
# /usr/lib/arm-linux-gnueabihf/dri should be a symlink and not a dir
rm -i /usr/lib/arm-linux-gnueabihf/dri
mv /usr/lib/arm-linux-gnueabihf/dri.org /usr/lib/arm-linux-gnueabihf/dri
# for aarch64 (64bit arm)
rm -i /usr/lib/aarch64-linux-gnu/dri
mv /usr/lib/aarch64-linux-gnu/dri.org /usr/lib/aarch64-linux-gnu/dri
# end of armv7l vs aarch64 sections
mv /opt/mesa /opt/mesa.off
ldconfig
apt-mark unhold libgl1-mesa-dri mesa-va-drivers
apt-get update
apt-get dist-upgrade
systemctl restart lightdm
# or to be more safe to really use the updated versions
reboot
```
if any or most probably most of the commands above fail with errors then most
probably the is no self built mesa installed and activated on the system

## steps to be done to go from bullseye=stable to bookworm=testing

- replace bullseye with bookworm in /etc/apt/sources.list
- run the following commands in this order (best not in xorg but in a regular
  framebuffer terminal to avoid potential trouble during the update):
```
apt-get update
apt-get upgrade
apt-get full-upgrade
```
- reboot and hope that everything is still working fine :)

## some notes about bookworm

with bookworm i saw for the first time xorg gamma settings via for instance
xcalib working on systems which support it (like rk3288, mt8173, mt8183 and
most probably some more) - i guess this is due to newer xorg etc.

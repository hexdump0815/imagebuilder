# some notes about running xorg with the nouveau gpu driver on nyan

- out of the box xorg does not work well or not at all together with the
  nouveau gpu driver (the actual situation seems to depend on kernel, mesa and
xorg version)
- the easiest solution (and the one used in the nyan images by default) is to
  simply disable gpu accel by using
/etc/X11/xorg.conf.d.samples/11-modesetting-no-glamor.conf as xorg config -
this works out of the box, but has not gpu accel
- there was some ugly hack to at least not let everything using the gpu via
  mesa crash with an assertation by simply dropping this assertation and
living with the resulting rendering errors - not sure if this is still an
option with recent kernels, xorg and mesa versions - this is that hack:
https://github.com/hexdump0815/mesa-etc-build/blob/131236e29392debc903e08a986ae99d9f97b38d5/tegra-hack.patch
and it comes from the issue 3505 mentioned in the links section below
- another solution was to build the dev version of the xorg server of around
  early 2021 and use that instead of the dist xorg server, this worked quite
ok, but ran into strange memory allocation errors on 4gb ram nyan systems
(again see the below mentioned issue 3505 for more details)
- the xorg server coming with bookworm currently (1.21.1.4) does not seem to
  work with mesa 22.x resulting in some strange alocation errors etc. even
with glxgears and glmark2
- a try to build the current dev version of the xorg server (21.1.99
  currently) did not work neither - some info about building the xorg dev
version and the resulting warnings and errors can be found here:
https://github.com/hexdump0815/mesa-etc-build/blob/03cc0e72b94529600f24a027158c3bc94034a933/xserver-build.txt
- it looks like the working old bullseye xorg server seems to work on bookworm
  as well if the bullseye input drivers are put into the package as well -
those xserver builds and some versions for bookworm/jammy with the
bullseye/focal input dirvers included can be found here:
https://github.com/hexdump0815/mesa-etc-build/releases/tag/21.0.1
- some links which might be interesting or relevant:
  - https://gitlab.freedesktop.org/mesa/mesa/-/issues/3505
  - https://gitlab.freedesktop.org/mesa/mesa/-/issues/6693
    - via: https://wiki.postmarketos.org/wiki/Acer_Chromebook_13_CB5-311_(google-nyan-big)
- in case someone finds out more or gets something working reliable and easily
  to reproduce, please open a github issue on this repo and share whatever new
or additional information is available

# how to install kernel headers for compiling software

## overview

the kernels used in those images here are usually not packaged and that for
two reasons:
- flexibility: it is much easier to build new kernels for all those images
  here with often different ways the kernels are built and provide them as a
simple tar archive than to also having to take care of their proper packaging
for all those different setups and requirements
- encouragement to build own kernels: i would recommend everyone to build your
  own kernels as this way they can be updated whenever wanted or needed and
its a nice way to learn and know a bit more about the system - links to notes
on how the kernels can be built can be found for all supported systems in the
readme for the corresponding system - it is not that complicated to build an
own kernel

as a result there are no kernel header (= kernel include files) packages for
them available. this is not a problem if own kernels are built and if the
kernel sources are still around on the system. otherwise it is quite easy to
add the header files afterwards to the system when needed.

## how to install the kernel headers for a given kernel

the kernel headers which are usually coming with the linux-headers-version
packages are referenced via symlinks in the /lib/modules/xyz directories - an
example (chromebook_veyron using a v5.19.3 stb-cbr+ kernel):
```
root@mighty:~# ls -l /lib/modules/5.19.3-stb-cbr+/source
lrwxrwxrwx 1 root root 37 Aug 24 10:50 /lib/modules/5.19.3-stb-cbr+/source -> /home/compile/source/linux-stable-cbr
root@mighty:~# ls -l /lib/modules/5.19.3-stb-cbr+/build
lrwxrwxrwx 1 root root 37 Aug 24 10:50 /lib/modules/5.19.3-stb-cbr+/build -> /home/compile/source/linux-stable-cbr
```
"/home/compile" on this system is symlinked from "/compile" which is the root
dir used for all kernel compiling described in the kernel build notes for the
different systems - "/home/compile/source/linux-stable-cbr" is the place where
the kernel sources are located. to make this work for a system where only the
kernel has been installed (but no kernel sources are around) the easiest way
is to simply install the kernel sources. for most cases the sources of a clean
kernel of the same version should be sufficient. so to keep the paths in the
above example (otherwise just change the symlinks to point to wherever else
the kernel sources get installed) the following commands have to be run (an
"apt-get install git" might be required beforehand):
```
mkdir -p /home/compile/source
cd /home/compile/source
git clone --depth 1 -b v5.19.3 https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-stable-cbr
```
that should be it. one thing to keep in mind is that not for all supported
systems the linux-stable git tree is used as a base - a look at the "gitrepo"
file of the dir containing the kernel build notes for the corresponding system
should tell which git repo to use - in most cases it is the one used in the
example above.

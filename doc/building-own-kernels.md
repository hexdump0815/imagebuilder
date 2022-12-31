# building own kernels

## intro

these notes are trying to describe the steps required to build own kernels based
on the notes provided for the different supported systems. it is not that
complicated to do and allows to build an up to date kernel when needed at any
time or to add kernel config options not enabled by default.

the structure used in the readme notes for the different kernels is a bit
hardcoded which is not perfect and might be replaced with a somwhat more
flexible approach, but for now it is as it is and if one prefers different
paths, then the paths in the readme would have to be replaced accordingly. the
directory structure is usually summarized at the top of the readme.

## basic assumptions

lets start with some basic assumptions:
- the kernel will be built on a system of the same architecture (like aarch64
  for an aarch64 kernel) and it is assumed that the running system where the
kernel gets compiled on is running a velvet os (imagebuilder) image
- there should be at least 10gb of free disk space available as the complete
  linux git tree is already around 6gb in size and more space is needed for the
compilation and the results. there are ways to reduce the space needed in case
there is not that much space available
- the gcc compiler and other required tools for the kernel compilation should
  be installed. simply running /scripts/install-buildtools.sh should install
everything required
- for many of the git repositories mentioned below git tags are used to mark
  specific versions which were built successfully and in most cases even
tested to be working, so it might be a good idea to start with such a tagged
version to have a higher chance to get a working kernel as a result

## directory structure

the directory structure used - example: odroid u3 kernel (stb-exy)
- the corresponding readme for this example is
  https://github.com/hexdump0815/linux-mainline-and-mali-generic-stable-kernel/blob/master/readme.exy
- /compile is the root dir for all the compilations - it can be symlinked to
  somewhere else if there is not enough space in the rootfs
- /compile/doc/stable (or a similar name mentioned in the head of the readme)
- /compile/source/linux-stable-exy - the kernel sources checked out from the
  git repo mentioned in the file gitrepo next to the readme  - see below for some
useful hints of how to optimize this a bit in case of limited space or building
multiple different kernels
- /compile/result/stable - the resulting kernel, modules etc. will end up in
  this dir as tar.gz files - it has to be created initially as an empty
directory
- /compile/doc/kernel-config-options - this is a clone of
  https://github.com/hexdump0815/kernel-config-options and is used to define
some common kernel config options used in the same way across multiple kernels,
see below for some more info
- /compile/doc/kernel-extra-patches - this is a clone of
  https://github.com/hexdump0815/kernel-extra-patches and contains extra out of
mainline tree patches used for all or most of the kernel builds - example: mglru
patches for improved memory handling

## checking out the kernel repo - example: odroid u3 kernel (stb-exy) v5.19.1

the normal way to checkout the kernel sources is to git clone the git repo
mentioned in the gitrepo file next to the readme inside of /compile/source and
afterwards rename it to the patch given at the head of the readme ans checkout
the desired kernel version from it (something like "git tag | grep v5.19" might
help to find out the latest version available for instance):
```
cd /compile/source
git clone https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git
mv linux-stable linux-stable-exy
cd linux-stable-exy
git checkout v5.19.1
```

in case there is not enough space to clone the complete tree, then a shallow
clone with a single commit depth can be done like
```
cd /compile/source
git clone --depth 1 -b v5.19.1 https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git
mv linux-stable linux-stable-exy
cd linux-stable-exy
```
which will occupy a lot less space, but also is less flexible than having the
full git tree around.

in case multiple kernels should be built on one system then it is a good idea to
clone some main git repo tree and create workdirs based on it. this will give
the flexibility of having the full git tree around and saves space as only a
minimal amount of files is used per checked out workdir tree (i.e. only the
source tree - all git internal metadata is only kept once in the central main
git repo tree.
```
cd /compile/source
git clone https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git
mv linux-stable linux-stable-repo
cd linux-stable-repo
git worktree add ../linux-stable-exy v5.19.1
cd ../linux-stable-exy
```
to update such a worktree to a newer kernel version make sure it is clean again
and then git checkout the desired version.
```
cd /compile/source
# first update the main git repo tree
cd linux-stable-repo
git pull
# go the the checked out worktree - see above
cd ../linux-stable-exy
# make sure the repo is clean
make distclean
git checkout -- .
# remove any leftover files now
# afterwards checkout the new desired version
git checkout v5.19.2
```

## building the kernel

this can be done following the corresponding readme file and large parts of the
commands can simply be copy and pasted from it. in principle building the kernel
according to the readme goes through the following steps:

- applying required patches
- creating the kernel config
- building the kernel, the modules and for many systems also the dtb files
- building some tools
- installing everything
- packaging everything into a tar.gz archive

it is a good idea to check if there is still enough disk space available in
/boot and /lib/modules before the installation step.

## what to do with the freshly built kernel to test and use it?

this is decribed in the file installing-a-newer-kernel.md

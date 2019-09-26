* get-files.sh - get precompiled kernels, bootloaders, mali libraries etc. needed from other repositories
* create-fs.sh - builds the filesystem for the image in a directory
* create-chroot.sh - is being called by create-fs.sh to execute some tasks chrooted into the directory created by it
* create-image.sh - creates a diskimage from the directory created by create-fs.sh

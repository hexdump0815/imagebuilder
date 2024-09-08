#!/bin/bash

if [ "$(whoami)" != "root" ]; then
  echo "This script must be ran as root."
  exit 1
fi

cd /boot || exit

# choosing kernel version

if [ "$#" != "1" ]; then
  echo "Note. no kernel specified, going with current kernel"
  kver=$(uname -r)
fi

if [ "$#" == "1" ]; then
  kver=${1}
fi

echo "kernel chosen ${kver}"

#checking presence of the kernel

if [ ! -e "Image-${kver}" ]; then
  echo "Image-${kver} seams to be missing"
  echo "this kernel version doesn't seam to be present"
  exit 1
fi

#it is better to regenerate initramfs everytime
#if [ ! -e initrd.img-${kver} ]; then
#  echo "initrd.img-${kver} seams to be missing, trying to generate"
  update-initramfs -c -k "${kver}"
#fi

if [ ! -e "initrd.img-${kver}" ]; then
  echo "sorry. unable to generate one TwT"
  exit 1
fi

if [ ! -e cmdline ]; then
  echo "cmdline seams to be missing"
  echo "Note. will create one for you"
  echo "console=tty1 root=LABEL=rootemmc rootwait ro fsck.fix=yes fsck.repair=yes net.ifnames=0 ipv6.disable=1 quiet splash" > cmdline
  
  #cbq requires additional cmdline
  if echo "$kver" | grep -q "cbq"; then
    echo "there is cbq"
    echo " deferred_probe_timeout=30 clk_ignore_unused=1" >> cmdline
  fi


  cat cmdline

fi

#generating required files
cp -v "vmlinux.kpart-initrd-${kver}" "vmlinux.kpart-initrd-${kver}.old" 2> /dev/null
cp "Image-${kver}" Image
lzma -9 -z -f -k -v Image
cp "initrd.img-${kver}" initrd.img.xz

#moved cmdline to seperate file to make it cleaner to edit
# for cbq add: deferred_probe_timeout=30 clk_ignore_unused=1
#echo "console=tty1 root=LABEL=rootemmc rootwait ro fsck.fix=yes fsck.repair=yes net.ifnames=0 quiet splash" > cmdline

dd if=/dev/zero of=bootloader.bin bs=512 count=1

# adjust to dtb names here:
# - cbg: dtb-${kver}/rk3399-gru-*.dtb
# - mt7: dtb-${kver}/mt8173-*.dtb
# - mt8: dtb-${kver}/mt8183-*.dtb
# - cbq: dtb-${kver}/sc7180-trogdor-*.dtb
# - generic: dtb-${kver}/*.dtb
#Note. you can specufy only dtb for your specyfic device to reduce space
#even further but lose portability. PLS BE CAREFUL, if you select wrong
#one the device will likely no work

ls dtb-${kver}/*.dtb | xargs printf " -b %s" | xargs mkimage -D "-I dts -O dtb -p 2048" -f auto -A arm64 -O linux -T kernel -C lzma -a 0 -d Image.lzma -i initrd.img.xz kernel.itb
vbutil_kernel --pack vmlinux.kpart --keyblock /usr/share/vboot/devkeys/kernel.keyblock --signprivate /usr/share/vboot/devkeys/kernel_data_key.vbprivk --version 1 --config cmdline --bootloader bootloader.bin --vmlinuz kernel.itb --arch arm
cp -v vmlinux.kpart "/boot/vmlinux.kpart-initrd-${kver}"

#cleanning up
rm -f Image Image.lzma initrd.img.xz bootloader.bin kernel.itb vmlinux.kpart


#final output

#getting where root is mounted from, /dev/mmcblk0p4 or /dev/sda4 or /dev/mapper/encrypted
root=$(findmnt -n -o SOURCE /)

#encrypted partitions are inside /dev/mapper/
if echo $root | grep -q "mapper"; then
  rawname=$(echo $root | sed 's/\/dev\/mapper\///') #first we remove useless part
  root=/dev/$(lsblk -no NAME --raw | grep -B1 $rawname | head -n 1) #then we get partition before encrypted on in lsblk
fi

#obtains the /dev/mmcblk1p or /dev/sda or similar
kpart=$(echo $root | sed 's/.$//')

#obtains parent disk, since sometimes there is p it otherwise would be tricky
pdisk=$(lsblk -no PKNAME $root | head -n 1)

#printing results
echo ""
echo "for single boot only testing:"

#echo "IMPORTANT: please double check your mmcblk device name beforehand"
#already take care of above

echo ""
echo "  dd if=/boot/vmlinux.kpart-initrd-${kver} of=${kpart}2"
echo "  cgpt add -i 2 -S 0 -T 1 -P 15 /dev/${pdisk}"
echo ""
echo "to always boot this kernel after successful testing:"
echo ""
echo "  dd if=/boot/vmlinux.kpart-initrd-${kver} of=${kpart}1"
echo ""


#!/bin/bash

# Linuxium's script to create a bootable SD card for Linux with RFS on USB for RK3288 devices
# extended by hexdump0815

MYTMPDIR="/tmp/r89-boot-tmp"

if [ ! -f ${MYTMPDIR}/kernel-linux.img ]; then
  echo ""
  echo "cannot find kernel image ${MYTMPDIR}/kernel-linux.img - giving up"
  echo ""
  exit 1
fi

if [ ! -f ${MYTMPDIR}/boot-linux.img ]; then
  echo ""
  echo "cannot find initrd image ${MYTMPDIR}/boot-linux.img - giving up"
  echo ""
  exit 1
fi

if [ ! -f ${MYTMPDIR}/resource-linux.img ]; then
  echo ""
  echo "cannot find resource image ${MYTMPDIR}/resource-linux.img - giving up"
  echo ""
  exit 1
fi

SDCARD="/dev/mmcblk0"

WORKING_DIR=`pwd`
TOOLS_DIR=/boot/r89-boot

RKCRC=${TOOLS_DIR}/rkcrc
SDBOOT=${TOOLS_DIR}/sdboot_rk3288.img

BOOT_PARTITION=false
KERNEL_PARTITION=false
RESOURCE_PARTITION=false

PARAMETER_FILE=/boot/r89-boot/parameter-linux
PARAMETER_IMAGE=${MYTMPDIR}/parameter-linux.img
BOOT_IMAGE=${MYTMPDIR}/boot-linux.img
KERNEL_IMAGE=${MYTMPDIR}/kernel-linux.img
RESOURCE_IMAGE=${MYTMPDIR}/resource-linux.img

CTRL_C()
{
	cd ${WORKING_DIR}
	echo
	echo "$0: Linux SD card creation interrupted ... exiting."
	exit
}

ERROR()
{
	cd ${WORKING_DIR}
	ERROR_MESSAGE=$*
	echo
	echo "$0: ${ERROR_MESSAGE} ... exiting."
	exit
}

START()
{
	cd ${WORKING_DIR}
	if [ $# -ne 0 ]; then
		ERROR "Usage: '$0'"
	fi
	if [ ! -f "${PARAMETER_FILE}" ]; then
		ERROR "Linux file '${PARAMETER_FILE}' not found"
	fi
	if [ ! -f "${BOOT_IMAGE}" ]; then
		ERROR "Linux image '${BOOT_IMAGE}' not found"
	fi
	if [ ! -f "${KERNEL_IMAGE}" ]; then
		ERROR "Linux image '${KERNEL_IMAGE}' not found"
	fi
	if [ ! -f "${RESOURCE_IMAGE}" ]; then
		ERROR "Linux image '${RESOURCE_IMAGE}' not found"
	fi
	if [ ! -f ${RKCRC} ]; then
		ERROR "Missing system tool '${RKCRC}'"
	fi
	if [ ! -f ${SDBOOT} ]; then
		ERROR "Missing bootloader image '${SDBOOT}'"
	fi
	NECESSARY=true
	while ${NECESSARY}; do
		echo -n "$0: Is your SD card loaded as '${SDCARD}' (y/n)? "
		read -n 1 ANSWER
		echo
		if [ "${ANSWER}" = "y" ]; then
			if [ ! -b "${SDCARD}" ]; then
				ERROR "Device '${SDCARD}' not found"
			else
				break
			fi
		else
			echo -n "$0: Do you want to use a different device? "
			read -n 1 ANSWER
			echo
			if [ "${ANSWER}" = "y" -o -z "${ANSWER}" ]; then
				echo -n "$0: Enter new device name? "
				read SDCARD
			else
				ERROR "Linux SD card creation terminated"
			fi
		fi
	done
	echo -n "$0: Unmounting partitions on '${SDCARD}' ... "
	umount ${SDCARD}? > /dev/null 2>&1
	echo "done."
}

FLASH_BOOTLOADER_TO_SDCARD()
{
	# XXX TEST
	#echo -n "$0: Formatting SD card '${SDCARD}' ... "
	cd ${WORKING_DIR}
	# XXX TEST
	#sgdisk -Z ${SDCARD} > /dev/null 2>&1
	#echo "done."
	echo -n "$0: Flashing bootloader '`basename ${SDBOOT}`' to '${SDCARD}' ... "
	# XXX TEST
	#dd if=${SDBOOT} of=${SDCARD} conv=sync,fsync > /dev/null 2>&1
	# zeroing the area where we will write the kernel to so that dumps of it compress well
	dd if=/dev/zero of=${SDCARD} conv=sync,fsync seek=64 count=262080 > /dev/null 2>&1
        # write the bootloader while skipping the unused beginning of it
	# the first 34 sectors of the 64 are gpt partition table, which we want to keep
	dd if=${SDBOOT} of=${SDCARD} conv=sync,fsync seek=64 skip=64 > /dev/null 2>&1
	echo "done."
	# XXX TEST
	#echo -n "$0: Updating partition table on '${SDCARD}' ... "
	#sgdisk -og ${SDCARD} > /dev/null 2>&1
	echo "done."
}

FLASH_LINUX_OS_TO_SDCARD()
{
	cd ${WORKING_DIR}
        echo -n "$0: Creating '${PARAMETER_IMAGE}' from '${PARAMETER_FILE}' ... "
        PARAMETER_IMAGE_CREATED=false
        rm -rf ${PARAMETER_IMAGE} > /dev/null 2>&1
        ${RKCRC} -p ${PARAMETER_FILE} ${PARAMETER_IMAGE} && PARAMETER_IMAGE_CREATED=true
        echo "done."
        if ${PARAMETER_IMAGE_CREATED}; then
		echo -n "$0: Flashing parameter '${PARAMETER_IMAGE}' to '${SDCARD}' ... "
		dd if=${PARAMETER_IMAGE} of=${SDCARD} conv=sync,fsync seek=$((0x2000)) > /dev/null 2>&1
		echo "done."
        else
                ERROR "Cannot create '${PARAMETER_IMAGE}'"
        fi
	echo -n "$0: Flashing boot '${BOOT_IMAGE}' to '${SDCARD}' ... "
	dd if=${BOOT_IMAGE} of=${SDCARD} conv=sync,fsync seek=$((0x2000+BOOT_START_PARTITION)) > /dev/null 2>&1
	echo "done."
	echo -n "$0: Flashing kernel '${KERNEL_IMAGE}' to '${SDCARD}' ... "
	dd if=${KERNEL_IMAGE} of=${SDCARD} conv=sync,fsync seek=$((0x2000+KERNEL_START_PARTITION)) > /dev/null 2>&1
	echo "done."
	echo -n "$0: Flashing resource '${RESOURCE_IMAGE}' to '${SDCARD}' ... "
	dd if=${RESOURCE_IMAGE} of=${SDCARD} conv=sync,fsync seek=$((0x2000+RESOURCE_START_PARTITION)) > /dev/null 2>&1
	echo "done."
}

CALCULATE_PARTITIONS_FOR_SDCARD()
{
	echo -n "$0: Calculating partition size for '${SDCARD}' ... "
	cd ${WORKING_DIR}
	for PARTITION in `cat ${PARAMETER_FILE} | grep '^CMDLINE' | sed 's/ //g' | sed 's/.*:\(0x.*[^)])\).*/\1/' | sed 's/,/ /g'`; do
        	PARTITION_NAME=`echo ${PARTITION} | sed 's/\(.*\)(\(.*\))/\2/'`
        	START_PARTITION=`echo ${PARTITION} | sed 's/.*@\(.*\)(.*)/\1/'`
        	LENGTH_PARTITION=`echo ${PARTITION} | sed 's/\(.*\)@.*/\1/'`
		case ${PARTITION_NAME} in
			"boot")
					BOOT_PARTITION=true
                			BOOT_START_PARTITION=${START_PARTITION}
                			BOOT_LENGTH_PARTITION=${LENGTH_PARTITION}
					;;
			"kernel")
					KERNEL_PARTITION=true
                			KERNEL_START_PARTITION=${START_PARTITION}
                			KERNEL_LENGTH_PARTITION=${LENGTH_PARTITION}
					;;
			"resource")
					RESOURCE_PARTITION=true
                			RESOURCE_START_PARTITION=${START_PARTITION}
                			RESOURCE_LENGTH_PARTITION=${LENGTH_PARTITION}
					;;
			*)
					;;
		esac
	done
	for PARTITION in BOOT KERNEL RESOURCE
	do
        	eval PARTITION_EXISTS=${PARTITION}_PARTITION
        	if ! ${!PARTITION_EXISTS}; then
                	ERROR "Linux's parameter file missing '`echo ${PARTITION} | tr '[:upper:]' '[:lower:]'`' partition definition"
        	fi
	done
	echo "done."
}

FINISH()
{
	echo -n "$0: Flushing buffers for '${SDCARD}' ... "
	sync
	sync
	echo "done."
        echo "$0: Linux SD card created on '${SDCARD}'."
}

trap CTRL_C SIGINT

START $*
FLASH_BOOTLOADER_TO_SDCARD
CALCULATE_PARTITIONS_FOR_SDCARD
FLASH_LINUX_OS_TO_SDCARD
FINISH

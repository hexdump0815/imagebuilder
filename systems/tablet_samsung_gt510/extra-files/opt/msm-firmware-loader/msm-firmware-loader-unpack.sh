#!/bin/sh
# SPDX-License-Identifier: MIT

#
# Some devices have their modem firmware packaged as .gz blobs.
# Those needs to be unpacked as Kernel can't handle .gz packed
# firmware at this time.
#

BASEDIR="/lib/firmware/msm-firmware-loader/target"

for blob in "$BASEDIR"/*.gz
do
	if ! [ -e "$blob" ]
	then
		exit
	else
		break
	fi
done

UNPACKDIR="$(mktemp -td "unpacked_fw.XXXXXX")"

for blob in "$BASEDIR"/*.gz
do
	blob_name="$(basename "${blob%.gz}")"
	gzip -d < "$blob" > "$UNPACKDIR/$blob_name"
	rm "$blob"
	ln -s "$UNPACKDIR/$blob_name" "$BASEDIR/$blob_name"
done


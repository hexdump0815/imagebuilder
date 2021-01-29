#!/bin/bash
#
# taken from https://gist.github.com/phizev/31185a30e7d4984724f1fbbf9c2afe19
# written size via https://askubuntu.com/questions/1021058/why-swap-is-touched-when-zswap-is-enabled-and-zswap-pool-is-not-full
#

ENABLED=$(cat /sys/module/zswap/parameters/enabled)
COMPRESSOR=$(cat /sys/module/zswap/parameters/compressor)
ZPOOL=$(cat /sys/module/zswap/parameters/zpool)
PAGE_SIZE=$(getconf PAGE_SIZE)
STORED_PAGES=$(cat /sys/kernel/debug/zswap/stored_pages)
POOL_TOTAL_SIZE=$(cat /sys/kernel/debug/zswap/pool_total_size)
REAL_SIZE=$(echo "scale = 0; $(LANG=c free -b | grep Mem | awk '{print $2}')" | bc -l)

if [ "$POOL_TOTAL_SIZE" = "0" ]
then
	DECOMPRESSED_SIZE_PRINT="N/A"
	RATIO="N/A"
	WRITTEN_SIZE_PRINT="N/A"
	VIRT_SIZE_PRINT="N/A"
else
	DECOMPRESSED_SIZE=$(echo "$STORED_PAGES * $PAGE_SIZE" | bc )
	DECOMPRESSED_SIZE_PRINT=$(numfmt --to=iec-i $DECOMPRESSED_SIZE)
	RATIO=$(echo "scale=3; $STORED_PAGES * $PAGE_SIZE / $POOL_TOTAL_SIZE" | bc -l)
	WRITTEN_SIZE=$(echo "scale = 0; ($(LANG=c free -b | grep Swap | awk '{print $3}') - $(cat /sys/kernel/debug/zswap/stored_pages) * $(getconf PAGESIZE))" | bc -l)
	WRITTEN_SIZE_PRINT=$(numfmt --to=iec-i $WRITTEN_SIZE)
	VIRT_SIZE=$(echo "scale = 0; $REAL_SIZE - $POOL_TOTAL_SIZE + $DECOMPRESSED_SIZE" | bc -l)
	VIRT_SIZE_PRINT=$(numfmt --to=iec-i $VIRT_SIZE)
fi

echo "Zswap enabled:            $ENABLED"
echo "Compressor:               $COMPRESSOR"
echo "Zpool:                    $ZPOOL"
echo
echo "Page size:                $PAGE_SIZE"
echo "Stored pages:             $STORED_PAGES"
echo "Pool size:                $(numfmt --to=iec-i $POOL_TOTAL_SIZE)"
echo "Decompressed size:        $DECOMPRESSED_SIZE_PRINT"
echo "Written to storage size:  $WRITTEN_SIZE_PRINT"
echo "Page compression ratio:   $RATIO"
echo "Total real mem size:      $(numfmt --to=iec-i $REAL_SIZE)"
echo "Total virtual mem size:   $VIRT_SIZE_PRINT"

if [ "$1" = "-v" ]
then
	echo
	grep -R . /sys/kernel/debug/zswap/
	grep -R . /sys/module/zswap/parameters/
fi

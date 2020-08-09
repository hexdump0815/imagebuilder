#!/bin/sh
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
POOL_SIZE=$(numfmt --to=iec-i $POOL_TOTAL_SIZE)

if [ "$POOL_TOTAL_SIZE" = "0" ]
then
        DECOMPRESSED_SIZE="N/A"
        RATIO="N/A"
        WRITTEN_SIZE="N/A"
else
        DECOMPRESSED_SIZE=$(echo "$STORED_PAGES * $PAGE_SIZE" | bc | numfmt --to=iec-i)
        RATIO=$(echo "scale=3; $STORED_PAGES * $PAGE_SIZE / $POOL_TOTAL_SIZE" | bc -l)
	WRITTEN_SIZE=$(echo "scale = 0; ($(LANG=c free -b |grep Swap |awk '{print $3}') - $(cat /sys/kernel/debug/zswap/stored_pages) * $(getconf PAGESIZE)) / 1024 / 1024" | bc -l)
fi

echo "Zswap enabled:            $ENABLED"
echo "Compressor:               $COMPRESSOR"
echo "Zpool:                    $ZPOOL"
echo
echo "Page size:                $PAGE_SIZE"
echo "Stored pages:             $STORED_PAGES"
echo "Pool size:                $POOL_SIZE"
echo "Decompressed size:        $DECOMPRESSED_SIZE"
echo "Written to storage size:  ${WRITTEN_SIZE}Mi"
echo "Page compression ratio:   $RATIO"

if [ "$1" = "-v" ]
then
        echo
        grep -R . /sys/kernel/debug/zswap/
        grep -R . /sys/module/zswap/parameters/
fi

# daily driving experiments

in order to see how useable the velvet os images are and to find some hidden
problems appearing only after real world long time usage i started to pick a
system from time to time and try to use it as my daily driver for about a
week. usage usually is firefox with a few dozen tabs open (so not just a
single tab) and running all the time (i.e. not restarted fresh each day) and
lots of termial sessions. the system is usually only switched between running
and suspend (or for low power system without supsend support running all the
time) and never really rebooted as long as it is running stable. when running
this way top with shift-h will show around 1500 threads, so actually quite a
few for such small systems. these notes are my findings from those experiments
for the different systems tried.

# general notes

- 2gb ram is only useable for 32bit systems or maybe 64bit systems with a
  32bit userland as 64bit systems usually need up to 50% more memory than
32bit systems (or the other way around: a 32bit userland only needs about
two thirds of the memory of a 64bit userland)
- if possible a 64bit userland is recommended over a 32bit one as nowadays the
  64 bit version receives more real world testing, but if there is not enough
memory 32bit is ok too - for arm more so than for intel as close to nobody is
still using 32bit intel anywhere, on arm there is still a lot of raspberry pi
stuff running on 32bit arm
- zswap memory/swap compression helps with the limited memory giving around
  25% more (virtually) available memory with the current setup without any
major impact as long as there are enough or fast enough cpu cores around to
handle the compression without any major side effects. raising the zswap
percentage to higher values does not bring too much in real world situations
as the kernel starts to get more and more busy comrpessing and decrompressing
memory. for systems with only 2gb of ram it might make sense to increase the
zswap percentage to 20% resulting in about one third of extra (virtually)
available memory. the zswap memory compression ratio seems to end up around
2.5-3 with the settings used for real world usage.
- switching the zswap pool allocation from z3fold to zsmalloc did not only
  solve problems with 32bit armv7l systems (see odroid u3 entry below for
more info) but also increased the memory compression level which can be
achieved (as with zsmalloc more than 1:3 is possible for well compressable
memory areas) from around 2.5-3 for z3fold to 3.5-4 (armv7l) or even around
5 (aarch64/x86_64) in real world desktop scenarios ... good zswap percentages
seem to be 20 for 4gb of ram or more or 33 for 2gb of ram
- the swap file should be of about the size of the ram size as a good starting
point - less might result in processes being killed from time to time due to
short bursts of high memory usage and more might result in a very slow system
due to a lot of swap io in the end. for systems with only 2gb of ram it might
be a good idea to provide about 150% of that as swap space (i.e. 3gb in that
case) as with zswap some swap space usage is counted twice: once for the
compressed memory (which is considered as used swap space by the system
although it is not written out to disk) and another time if a small fraction
of that really gets written to disk in the end (if more memory is required
than can be made available by compression) - see /scripts/zswap-status.sh to
see how much is really written to the swap file (usually much less than what
is shown in 'top' or 'free'. if there is enough disk space available it might
be even with 4gb ram or more a good idea to size the swap space as 150% of the
physical memory or even better as 200%.
- btrfs transparent filesystem compression helps quite well with the usually
  rather small storage sizes of chromebooks or other small devices by
providing around 50%-100% more (virtual) disk space depending on what files
are being stored - with this it is possible to run linux quite well even on
systems with 16gb of storage - even less is possible, 32gb is getting quite
comfortable and 64gb or more is plenty of disk space ...
- most of the images enable all the above mentioned features by default
- please keep in mind that this is just a look at daily usage keeping in mind
  that the systems are usually not the most powerful ones, so no wonders are
expected and especially there is no focus at all on gpu performance, gaming
usage, video hardware decoding etc. (i.e. for instance as long as it is
possible to somehow watch youtube videos at an somewhat acceptable resolution
it is considered to be ok, it does not matter if its 8k, 4k, full hd, hd or
even less)
- from my experience the overhead from running a luks encrypted root fs can
  be neglected on current systems, so it is nothing to worry about performance
wise
- running from emmc (or even ssd) as storage makes a big difference for daily
  use compared to running from sd cards - if sd cards are used, a1 rated ones
should be choosen as they have much better random io, which is often happening
in such a use case - regular (non a1 rated) sd cards are often very slow for
desktop usage to the point of being close to unuseable - most cheap usb
storage devices can be considered to behave similar to non a1 rated sd cards
and thus it is recommended to use high quality usb devices like sandisk ultra.

# chromebook oak - elm - august 2022

- tested for more than two weeks
- it was working surprisingly well and reliable
- notes: no gpu support and display power management is not working well (but
  worked around by the default settings)
- info: v5.19.1 kernel, debian bullseye, 4gb ram, 32gb emmc
- update: retested for a few weeks in december 2022 with a v6.1.0 kernel and
  it was working perfectly fine all the time and the battery life for light
usage was often around 12 hours +/-

# chromebook veyron - mighty - august 2022

- tested for about a week
- it was working surprisingly well and reliable
- notes:
  - panfrost driver had to be disabled as the system was getting unstable
  (kernel memory allocation issues) with it as soon as firefox was used heavily
  - besides that firefox had to be restarted after about 3 days due to too high
  memory usage most probably due to memory leaks in firefox
- update: it looks like the panfrost driver isssues were due to using the
  z3fold pool allocator for zswap - using zsmalloc instead seems to not bring
up such problems - see the odroid u3 entry below for more details
- info: v5.19.3 kernel, debian bookworm, 2gb ram, 16gb emmc

# chromebook kukui - krane - september 2022

- tested for about a week
- it was working surprisingly well and reliable
- notes: the display was very nice to work with when scaled down via xrandr
  scaling to 1280x800
- info: v5.18.10 kernel, debian bookworm, 4gb ram, 64gb emmc

# chromebook x86 uefi - bloog - september 2022

- tested for about a week
- it was working surprisingly well and reliable
- notes: i started running from sd card which did not perform too well, but 
  since moving to emmc everything seemed to run perfectly fine
- info: v5.19.6 kernel, debian bookworm, 4gb ram, 64gb emmc, n4000 2 core cpu

# chromebook snow - september 2022

- tested a few hours and then given up on it - it is getting too slow to be
  really useable for a longer time as soon as it gets used more heavily
- notes: it looks like having only 2gb ram (i.e. having to make quite a bit of
  use of memory/swap compression) and only two not too powerful cpu cores is
the limiting factor here
- info: v5.18.1 kernel, debian bookworm, 2gb ram, 16gb emmc

# amlogic gx - h96max x3 s905x3 tv box - september 2022

- tested for about a week
- it was working reliable and quite ok
- notes: after a while of use the system stalls for a moment from time to time
  and i initially suspected it to be panfrost related again as on rk3288, but
after disabling panfrost the stalls still appeared from time to time and the
reason seems to be that i was running from an sd card instead of emmc and the
stalls seem to happen whenever data is being written to the swap file - so it
looks like even the better a1 rated sd cards are still far behind emmc even if
they are way better than regular sd cards - beside those stalls from time to
time the system was quite useable
- info: v5.19.1 kernel, debian bookworm, 4gb ram, 32gb a1 sd card

# rockchip rk3328 - t9 rk3328 tv box - september/october 2022

- tested for about a week
- it was working reliable and quite ok
- notes: due to the not that fast cpu (4xa53 at 1.3ghz) it is not the fastest
  system, but it is still useable - running from emmc instead of sd card helps
to compensate a bit for that
- info: v5.19.1 kernel, debian bookworm, 4gb ram, 32gb emmc

# amlogic gx - mi box s905x tv box - october 2022

- tested for a few days
- it was working reliable and quite ok, but somewhat slow
- notes: due to the not that fast cpu (4xa53 at 1.4ghz) it is not the
  fastest system - combining this with only 2gb ram does not really help and
using a 64bit kernel with a 32bit userland is the only option to be able to
really use it as a desktop system for a bit heavier use. putting the swap
onto some area of the emmc was helpful in combination with a high quality usb
stick for the root filesystem (the mi box does not have an sd card slot). with
all that the system was kind of useable in the end, but rather on the slower
end and some patience is required now and then.
- info: v6.0.0 kernel, debian bookworm (32bit userland), 2gb ram, 32gb sandisk
  ultra usb stick for the system and 5gb android data partiion area on emmc
for swap

# amlogic gx - a95xr2 s905w tv box - october 2022

- tested for a few days
- it was working reliable and quite ok, but quite slow
- notes: this was the try to go a bit lower even than for the last test with
  the amlogic s905x as the s905w is even slower (4xa53 at 1.2ghz), so all
from above is valid here and the system is even a bit slower. running from
emmc here instead of a usb stick on the s905x might help a bit here. to my
surprise the analog audio output of the box was actually working after doing
some minimal setting changes in alsamixer - i did not actualy expect this :)
- info: v6.0.0 kernel, debian bookworm (32bit userland), 2gb ram, 16gb emmc

# atom 32bit uefi - linx 1010b 2in1 - october 2022

- given up after a day
- it was working reliable and quite ok, but too slow
- notes: i expected it to be faster than the amlogic s905w (faster out of
  order intel cpu cores - 4xatom at up to 1.8 ghz vs. slower in order arm cpu
cores - 4xa53 at 1.2ghz), but it was at least as slow if not even slower than
that, most proably still quite useable for lighter load (just a few tabs in
firefox etc.) but not really in the tested scenario. again due to the only 2gb
of ram a 32bit userland was used to keep memory usage lower.
- update: i retested this one when i retested the odroid u3 with the mglru
  min_ttl_ms option, but it did not help - interestingly it seemed to use much
more memory on 32bit i686 than on 32bit armv7l for some strange reason which
resulted in it reaching the limits of useability earlier
- update: i retested this one with the zsmalloc zswap option and it seems to
  be a bit more useable, but it still is quite slow to use not at last due to
the only 2gb of ram i think - arm systems seem to be able to deal a bit better
with 2gb or ram and 32bit userland than x86 it seems
- update: it looks like my test case simply gets a bit too heavy for systems
  with 2gb of ram as using a rk3288 veyron chromebook with also 2gb ram again
later showed the same slowness due to zswap spending a significant amount of
time for compressing/decompressing memory - for lighter load such systems
should still be quite useable
- info: v6.0.0 kernel, debian bookworm (32bit i686 userland), 2gb ram, 32gb
  emmc

# chromebook x86 uefi - blooglet - october 2022

- tested for about two weeks
- it was working surprisingly well and reliable
- notes: it was a joy to use after testing all the lower spec systems over the
  last weeks - 4gb of ram and at least 4 cpu cores of useable speed are really
recommended for daily use if possible - with those specs using the system is
really comfortable compared to everything with lower specs
- info: v6.0.0 kernel, debian bookworm, 4gb ram, 64gb emmc, broken keyboard,
  so it was used with usb kbd and mouse, n5000 4 core cpu

# chromebook kukui - kappa - october 2022

- tested for about a week
- it was working surprisingly well and reliable
- notes: it was as useable as the blooglet due to the 8 cpu cores and 4gb of
  ram - using the system is really comfortable ... only thing noticed: with
the usb hub (on the usb-a port) i usually use for mouse, keyboard an ethernet
the mouse simply did not work and always gave usb errors, with another usb hub
(on the usb-c port) everything was working fine
- info: v6.0.0 kernel, debian bookworm, 4gb ram, 32gb emmc

# odroid u3 - october 2022

- given up early on during initial tests
- it was not really working well as processes got oom killed after some
  heavier firefox useage
- notes: i always wanted to know if it is meanwhile possible to use the trusty
  old odroid u3 as a desktop system due to all the new clever features like
zswap, mglru etc. and it looks like it might be possible (albeit rather slow)
but as soon as firefox got used a bit heavier the kernel oom killed a lot of
processes and with them usually the whole org session, so not a good base for
using it as a desktop ... there were some locking errors in dmesg as well, so
some deeper investigation might be required to get this going
- update: it looks like setting "echo 100 > /sys/kernel/mm/lru_gen/min_ttl_ms"
  or even set this to 0 can mitigate the problem a bit but looks like even
with that some oom kills can still happen under high cpu and memory pressure
- update: some more investigation showed that the problem seems to be a system
  with little memory, enabled zswap with a high percentage configured and
enabling mglru seems to make things worse - zswap at 33%, mglru disabled
seems to end in oom kills, zswap 20% and no mgrlu seems to still run well,
zswap 20% and mglru enabled seems to end in oom kills and zswap disabled and
mglru enabled seems to work well - all this is with
/proc/sys/vm/watermark_boost_factor and /sys/kernel/mm/lru_gen/min_ttl_ms
set to 0 - this seems to apply to at least all 32bit armv7l systems with only
2gb of ram (but maybe other combinations are affected as well)
- update: the oom kill problem is finally solved thanks to the mglru author
yu zhao and quite a bit of testing - see:
https://github.com/hexdump0815/imagebuilder/commit/149edb06d079043645971e2a43ca35276ac4e04e
- info: v6.0.0 kernel, debian bookworm, 2gb ram, 32gb a1 sd card

# rockchip rk33xx - pinebook pro - october/november 2022

- tested for about a week
- it was working surprisingly well and reliable
- notes: it was as useable as the blooglet and the kappa before due to the 6
  cpu cores and 4gb of ram - using the system is really comfortable ... i did
some experiments with increasing the zswap percentage to 33 while setting the
swap space to 200% ram (i.e. 8gb) and it seemed to work quite well and it
looks like as a result less data was actually writte to the physical swap
space
- info: v6.0.0 kernel, debian bookworm, 4gb ram, 64gb emmc

# chromebook x86 mbr - lenovo thinkpad x201 - november 2022

- tested for about a week
- it was working well and reliable
- notes: it was as useable as the other systems with 64bit cpu, 4gb ram and
  a reasonable fast cpu - using the system is comfortable ... i did some more
experiments with increasing the zswap percentage to 33 while setting the
swap space to 200% ram (i.e. 8gb) and it seemed to work quite well, but did
not give any really strong advantage ... it was interesting and a bit annoying
to use a system with a fan again after nearly only using fanless ones for the
last months if not years, a custom thinkfan config helped a bit, but a system
without a fan is way nicer ...
- info: v6.0.0 kernel, debian bookworm, 4gb ram, 80gb ssd, i5 m520 2/4 core
  cpu

# chromebook nyan - big - november 2022

- tested for a few days
- it was working well and reliable, but not that fast due to only 2gb ram
- notes: it was not as nicely useable as the systems with 4gb ram but it was
  still useable ... mglru had been disabled due to the mysterious oom kill
issues already seen on the odroid u3 and meanwhile sorted out (see the odroid
u3 entry above for details) but it should be possible to reenable mglru
again after switching zswap to zsmalloc to gain some extra performance and
response ... during the testing glamor (i.e. the gpu) was disabled in xorg
and the regular debian bookworm mesa and xorg were used as otherwise firefox
did crash from time to time
- update: as assumed with zswap set to zsmalloc the system was running stable
  again, even with mglru enabled during some retesting
- info: v6.1-rc3 kernel, debian bookworm, 2gb ram, 32gb emmc

# chromebook kukui - juniper - novemeber 2022

- tested for a few days
- it was working surprisingly well and reliable
- notes: as expected exactly as useable as kappa above, even including the
  usb hub and mouse problems :)
- info: v6.0.0 kernel, debian bookworm, 4gb ram, 64gb emmc

# chromebook x86 uefi - kefka - november 2022

- tested for about a week
- it was working very well and reliable, but there were some problems
- notes: everything was working quite well and fluid due to 4gb ram and even
  with 2 cores it seemed to be quite ok, but there seem to be some bugs in
the used debian bookworm: one is related to the current firefox-esr 102 which
seems to kind of hang after some time (i.e. getting very very slowly
responding, no messages anywhere and everything else is working fine - found
a few other reports about problems with this version currently as well) and
the other bug seems to be related to the i915 drm and/or gpu driver which
results in a black screen from time to time with the message "[drm] *ERROR*
CPU pipe A FIFO underrun" - a suspend/resume cycle usually brought the display
back reliably (found a few other reports about such problems as well)
- update: a custom modprobe config is required to avoid a bug with baytrail
  and braswell based systems where their audio will switch to a beeping sound
after some minutes usually which can be worked around by uncommenting a line
in the sound-byt-cht.conf modprobe config file
- update: it looks like intel_idle.max_cstate=3 or =4 might help to avoid the
  above mentioned gpu problems (not yet tested)
- update: max_cstate 4 and 3 did not fix the screen blanking issue, testing 2
  now ... at least the firefox 102-esr problem should be addressed in a future
firefox version - see: https://bugzilla.mozilla.org/show_bug.cgi?id=1781167
- update: it looks like intel_idle.max_cstate=2 seems to fix the blank display
  issues - at least it was running without any problems for a few days this
way
- info: v6.0.9 kernel, debian bookworm, 4gb ram, 32gb emmc, n3060 2 core cpu

# chromebook veyron - jaq - november 2022

- tested for a day
- it was working ok, but quite slow - close to too slow
- notes: it looks like 2gb or ram is a bit too little for my current workload
  meanwhile, panfrost was enabled again and everything was working fine this
time, most probably because the zsmalloc zswap pool allocator was used instead
of the more problematic z3fold one used before, zswap percentage of 33 seemed
to work best as it resulted in close to no real swap to disk which still slows
down the system even more when using lower zswap values on a 2gb ram system
... btw. it looks like the firefox-esr 102 problem already mentioned above for
kefka came along on jaq after a while of usage as well ...
- update: right after writing this i got kernel messages which look like the
  old panfrost problems again, so it might be a good idea to keep it off in
case the system is not stable otherwise ...
- info: v6.0.0 kernel, debian bookworm, 2gb ram, 16gb emmc

# chromebook x86 uefi - clapper - november 2022

- tested for about a week
- it was working very well, fluid and reliable
- notes: not much to say, it simply worked very well without any of the
  problems observed with kefka above - the only ajustment was a custom
modprobe config required to avoid a bug with baytrail and braswell based
systems where their audio will switch to a beeping sound after some minutes
usually which can be worked around by uncommenting a line in the
sound-byt-cht.conf modprobe config file (and which was required for kefka
above as well in the end) ... zswap was used with 20% zsmalloc and a 4gb swap
file plus mglru was enabled and those settings worked very well
- info: v6.0.0 kernel, debian bookworm, 4gb ram, 16gb emmc, n2830 2 core cpu

# chromebook oak - hana - november/december 2022

- tested for a few days
- it was working very well, fluid and reliable
- notes: not much to say, it just worked as expected without any real problems
  and has a very good battery life of 10-12 hours if just lightly used - the
only thing to keep in mind is that there is still no support for its gpu in
the mainline kernel and mesa, but for normal web, shell and office usage this
does not really have any negative impact
- info: v6.0.0 kernel, debian bookworm, 4gb ram, 32gb emmc

# chromebook x86 uefi - chell - january 2023

- tested for more than a week
- it was working very well, fluid and reliable
- notes: this system has a skylake cpu and it seems like audio is broken in
  all recent kernels above around v5.13 so a switch back to the last lts
kernel with working audio v5.10 was required
- info: v5.10.162 kernel, debian bookworm, 4gb ram, 32gb emmc, m3-6y30
  2/4 core cpu

# chromebook trogdor - lazor - january 2023

- tested for a few days
- it was working very well, fluid and reliable
- notes: i had access to a lazor again for a few days and used the time to
  test it in daily use. not much to say, it just worked as expected without
any real problems and has a very good battery life of around 10 hours +/- if
just lightly used.
- info: v6.1.1 kernel, debian bookworm, 4gb ram, 64gb emmc

# chromebook gru - bob - january 2023

- tested for a few days
- it was working very well, fluid and reliable
- notes: not much to say, it just worked as expected without any real problems
  and has a very good battery life which is depending a bit on usage pattern,
but should be somewhere in the range of 6-10 hours. the only thing i noticed
is the the sceen blanked (short moment of black screen) from time to time for
a very short moment, not sure if it is a general problem or only a temporary
issue of the kernel version used. in the end it happens so rarely and the
blanking is so short that it is not really a problem.
- info: v6.1.0 kernel, debian bookworm, 4gb ram, 16gb emmc

# chromebook veyron - minnie - january 2023

- tested for a few days
- it was working well, relatively fluid and reliable
- notes: this is the first time again for quite a while that a 32bit system
  with only 2gb ram was really useable in my daily drive usage scenario - i'm
not sure if there are any improvements in the kernel or firefox which made
this possible as the last times i tried it such a setup simply was not useable
for a longer time - this time it really worked quite well, although of course
a little slower and less snappy than 64bit systems with 4gb or ram ... the
panfrost gpu driver was disabled again due to problems with it in earlier
tries and the zswap percentage was set to 25% which seems to be a very good
value in general, the swap file size was 4gb in this setup
- info: v6.1.7 kernel, debian bookworm, 2gb ram, 16gb emmc

# status updates and news around this project

## january 2025

it might look like there is not that much happening around velvet os, but there
is quite a bit happening behind the scenes - here is a little overview about
what is currently happening around this project:

- sadly my time is still quite limited so that i cannot put as much
  effort into the project as i would like to, but at least i'm able to work on
it from time to time again now with the hope of it getting more over time
- besides saying thanks to everyone who contributed to this project by creating
  pull requests, investigating problems, responding in github issues etc. a
very special thank you goes to luk for his rework and massive extension of the
documentation (especially for chromebooks), the creation of the velvet tools
for better bootable kernel image creation on aarch64 chromebooks, for a lot of
testing and feedback and for his support within many github issues.
- the final planning for the next two planned releases (one in spring and one
  in autumn) is in progress - see:
https://github.com/hexdump0815/imagebuilder/discussions/284 and
https://github.com/hexdump0815/imagebuilder/discussions/285
- kind of behind the scenes there is the v6.12 kernel testing in process since
  v6.12 has been released and the kernels for many systems have been adjusted
to v6.12 and tested to be working in prepararion to use them for the upcoming
spring 2025 release of velvet os - see:
https://github.com/hexdump0815/imagebuilder/discussions/267
- as part of the kernel preparations for v6.12 there is now a unified kernel
  for the different mediatek chromebooks instead of separate kernels for the
different soc versions (tested on oak, kukui and corsola so far)
- two new devices got added by luk to the image building framework:
  https://github.com/hexdump0815/imagebuilder/tree/main/systems/console_x55 and
https://github.com/hexdump0815/imagebuilder/tree/main/systems/console_rg552
- chromebook_corsola starts to be useable with a mainline kernel (still some
  topics open like sound and suspend, but far better than it was in the past)
- for some devices the upcoming debian trixie and ubuntu noble images might be
  the last round of images as there is not that much support for the hardware
anymore upstream and it gets more and more painful to keep them working, plus
the user base is quite small. those systems currently would be:
chromebook_snow, chromebook_nyan, allwinner_h3, amlogic_m8 and tablet_amazon_*
... but even with that those devices will still be useable for at least 3-4 (or
even more) years with the option to have an up to date kernel and system
running on them thanks to the long term support of the v6.12/v6.6/v6.1 kernels
and of debian trixie ...

## september 2024

in this new news.md file from now on there will be status updates and news regarding this project every now and then to give everyone interested informed about what is going on and planned.

### the project is still alive

first a few words about the rather calm state of this project during the last months - if you look at the commit history it might look like the project is dead, but it is still alive - its just that i currently have close to no time to really push it forward due to real life topics keeping me very busy at the moment ... there is just enough time to follow the github issues and some other communication channels, but not for extensive debugging, experimenting, bisecting etc. to really move things forward. the good news is that it looks like i'll have more time for it again starting end of this year / beginning of next year. as a result i'm currently planning some next round of images early next year - see below. another good thing is that the now mostly around one year old images still seem to be quite useable to get started on the supported systems and the provided notes about building newer kernels etc. seem to be useable as well to some degree to move a bit forward if desired.

### discussions

in the hope to make discussing topics and helping each other with the images maybe a bit better and/or easier i have just enabled github discussions for this project. there are labels matching all of the supported systems of the imagebuilder framework - please add the according label(s) to your discussions to make it easier to keep the overview. There are also more generic labels for topics related to chromebooks in general etc.

### plans and priorities

the following are the topics i would like to address in the next round of images early next year:

- better documentation ... there are quite a few notes available for various topics like building kernels, installing to emmc on chromebooks etc. in the doc folders, but to have more topics documented can't be wrong and also improving the quality of the existing documentation will for sure help ... besides that there is also some work in progress from thenameisluk which should improve the situation in this area in the future
- more kernel testing required ... the quality of the mainline support for the various chromebook models varies quite a bit: some things work very well, some things work so-so, other things are simply broken or break with newer kernel versions ... it would be nice if more people interested in playing around with the kernel on their devices could join in trying out new kernel versions, checking for existing but not yet mainlined patches to add or even better upstream them, bisecting regressions in newer kernel versions etc. ... i plan to add some infrastructure for this (github issues or discussion threads with information about what to do, how to do it and where to search for information) soon
- better booting support for 64bit arm chromebooks ... chromebooks have their own special bootloader (depthcharge) which requires some special preparation of the kernels to be booted and the plan is to integrate some better infrastructure to do those preparations into the images ... also here some promising work in progress exists from thenameisluk
- move to debian trixie and ubuntu noble: i would expect debian trixie to be released around summer 2025 and the idea is to start providing mostly trixie images for debian with the next round as it will bring a lot of updated packages which will help in many areas and the move to the properly released version should be as smooth as it was with bookworm as well in the past ... ubuntu noble support is in the scripts already, but there still are some issues to be adressed like the kernels have to be adjusted to support loading zstd compressed firmware files etc.

lets have a look at the current priority list for the next steps by system (besides the generic topics mentioned above):

- kukui and trogdor chromebooks: those cover the most chromebooks around i think, they are very useable with a very good battery life and they can be bought for very good prices (especially used), so they will be in the main focus for now ... major topics to be adressed would be the partially a bit broken usb stack resulting in some usb devices not working well or not at all on them and for kukui trying to get support for connecting external monitors working via usb-c dp-alt mode which is not working / broken currently
- oak and gru chromebooks: these are still very useable systems and widely available ... things to look into are sorting out special problems which were reported via github issues around connecting certain monitors, suspend mode etc. and for oak maybe adding gpu support via the new pvr driver slowly finding its way into the mainline kernel and mesa, but it might still be too early to get it working and useable on these devices
- corsola, asurada and cherry chromebooks: so far there are only some basic testing images available for those newer chromebooks and the next step would be to try to create some new and closer to mainline kernel based images which will most probably still require quite a few extra patches to be found and sorted out
- snow, peach, veyron and nyan chromebooks: for those older 32bit chromebooks the main target would be to clean up the images a bit more where possible as i do not expect too much to happen in the kernel and in mesa for them anymore ... it would be nice if someone would look a bit deeper into the gpu support which is not the best for all of them (recheck the drm and hdmi patches for veyron and maybe playing around with the new nvk driver for nyan)
- odroid u and x: the plan is to continue to provide updated useable images for those meanwhile around 10 year old sbc's as they still seem to be in good use in many places
- everything else: all other images will be worked on step by step as well, but maybe later after the the above mentioned ones are ready

### thanks

a lot of thanks to all of you who have contributed to this project with patches, pull requests, research, documentation (and fixes for it), ideas, support in the github issues and in any other way - please continue to do so as this project will of course profit from all the positive input and feedback it gets - thanks a lot!

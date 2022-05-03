# velvet os - an introduction

this is a simple framework for building bootable sd card images for various (currently imostly arm based) small computer like devices. it is supposed to run natively, i.e. if you want to build an image for a 32bit arm system you should run it on a 32bit arm system and so on. i started it when i wanted to easily and reproducably build bootable sd card images for some arm devices for which there are no such images with recent distributions and linux kernels available or do not exist at all. i'm aware of the armbian (https://www.armbian.com/) framework, which has a similar goal and is much more advanced, but i wanted something simpler so that i can easier adjust it for prototyping and i wanted to build everything natively as i do not really have any strong intel machine for cross compiling. if anyone with amrbian knowledge and a proper build environment is interested to port over the patches etc. for the few systems not yet supported by armbian to it, that would be more than welcome.

please keep in mind that the intention of those images is to make it easier to get started on not too well supported systems or setups. they are not intended as a fully end user ready distribution - some fine tuning and adjustment will most probably be required still to make them fully working, but at least you do not have to think about how to get some device booting or where to get a working kernel from etc. - as such it should be a very good starting point for anyone with some (or more) linux experience and for anyone wanting to learn more about the system they are using.

the framework supports building debian and ubuntu images as they are very widely used linux distributions and they are very close to each other in the way they are designed and work (package mangement etc.). the chance that support for other linux distributions will be added is rather low as this would make things way more complicated and one of the basic ideas of this framework is to be small and simple while still being quite flexible. it currently supports more than 30 different systems (which might support multiple separate devices each in many cases) and the level at which they are supported varies a bit among them, but for all of them at least some bootable images exist to get started to maybe improve them further. the systems with the most focus currently are most probably chromebooks (i.e. running a proper linux system instead of chromeos on them) as they are a perfect option to run linux on an arm soc based notebook at a very good price point and the odroid u/x series of sbc devices as there seem to be no other regularly maintained linux for them anymore otherwise.

for communication github issues should be used. before creating a new one, please check if there is maybe already another one regarding the topic or problem existing and when creating a new one it is very important to always include all the basic information required, like which hardware is used, which image is used, in case of problems: how exactly do they manifest (instead of just "does not work") and in which context do they appear. with all this please keep in mind that this is not a product, but a spare time project done and supported by volunters - so it might take time until there is a solution, answer or suggestion or there might be even none. there is one special category of issues so far which is dealing with the state of certain systems and they have subjects like "system status: chromebook_trogdor: coachz" - so it might be a good idea to search the github issues for such "system status" information for a certain system.

finally some notes about the name: the framework did not have any real name so far besides "imagebuilder", but as this is hard to find and not so easy to reference i have decided to give it some name, so it can be referenced easier than as "images built with the hexdump0815 imagebuilder framework" :) - lets call it "velvet os" from now on. the name comes from the fact, that i sometimes use self-adhesive velvet to cover the (sometimes heavily scratched) top of my chromebooks, which has the nice side effect to let all the marketing branding of the device disappear, making it a perfect velvet os device ...

# creating images

see scripts/readme.md as a start

more coming soon ...

# using the images

simply write/flash (not just copy!) the images to an sd card - there is a lot of documentation about how to do this on the web. the images require an sd card of at least 8gb size (for the newer images even 4gb sould be enough) - more is no problem and can be made useable after the first boot of the image.

the images provided are ubuntu 20.04 lts (focal) with the xubuntu desktop environment. debian 11 (bullseye) with the xfce desktop environment will be added as soon as it gets officially released. they have a user named "linux" configured with the password "changeme" and sudo permission (use "sudo -i" to get root). the hostname is set to "changeme". they are assuming a us keyboard and are setup for english, so one should configure it as needed after the first boot - a good start might be:

* locale: dpkg-reconfigure locales
* timezone: dpkg-reconfigure tzdata
* console keyboard (run this on the console if needed at all): dpkg-reconfigure keyboard-configuration
* console (run this on the console if needed at all): dpkg-reconfigure console-setup

or even simpler, just use the various graphical settings tools installed.

some commands to set the keyboardmapping in an x terminal:

* english: setxkbmap us
* french: setxkbmap fr
* german: setxkbmap de
* italian: setxkbmap it
* portuguese: setxkbmap pt
* russian: setxkbmap ru
* spanish: setxkbmap es
* ...
* onscreen keyboard: apt-get install matchbox-keyboard ; matchbox-keyboard
      alternatively: apt-get install onboard ; onboard
* for console: loadkeys us (etc. like above)

to use all the space on your sd card, please run the following script as root after the first boot: "/scripts/extend-rootfs.sh"

more coming soon ...

# system specific information

- allwinner h3 devices and tv boxes: https://github.com/hexdump0815/imagebuilder/blob/main/systems/allwinner_h3/readme.md
- allwinner h6 devices and tv boxes: https://github.com/hexdump0815/imagebuilder/tree/main/systems/allwinner_h6#readme
- amlogic gx (gxbb=s905, gxl=s905x/s905w, gxm=s912, g12a=s905x2, g12b=s922x and sm1=s905x3) devices and tv boxes: https://github.com/hexdump0815/imagebuilder/blob/main/systems/amlogic_gx/readme.md
- amlogic m8 (s802, s805 and s812) devices and tv boxes: https://github.com/hexdump0815/imagebuilder/blob/main/systems/amlogic_m8/readme.md
- intel 64bit atom (z3735f, z3470d, z8300, z8350 etc.) systems (often tablets) with 32bit uefi bios: https://github.com/hexdump0815/imagebuilder/blob/main/systems/atom_x86_with_32bit_uefi/readme.md
- arm exynos 5250 32bit chromebook snow: https://github.com/hexdump0815/imagebuilder/blob/main/systems/chromebook_snow/readme.md
- arm exynos 5250 32bit chromebook spring: https://github.com/hexdump0815/imagebuilder/blob/main/systems/chromebook_spring/readme.md
- arm exynos 5420 32bit chromebooks peach: https://github.com/hexdump0815/imagebuilder/blob/main/systems/chromebook_peach/readme.md
- arm tegra k1 32bit chromebook nyan: https://github.com/hexdump0815/imagebuilder/blob/main/systems/chromebook_nyan/readme.md
- arm rockchip rk3288 32bit chromebooks veyron: https://github.com/hexdump0815/imagebuilder/blob/main/systems/chromebook_veyron/readme.md
- arm rockchip rk3399 64bit chromebooks gru: https://github.com/hexdump0815/imagebuilder/blob/main/systems/chromebook_gru/readme.md (wip)
- arm mediatek mt8173 64bit chromebooks oak: https://github.com/hexdump0815/imagebuilder/blob/main/systems/chromebook_oak/readme.md
- arm mediatek mt8183 64bit chromebooks kukui: https://github.com/hexdump0815/imagebuilder/blob/main/systems/chromebook_kukui/readme.md
- arm qualcom 7c sc7180 64bit chromebooks trogdor: https://github.com/hexdump0815/imagebuilder/blob/main/systems/chromebook_trogdor/readme.md
- intel chromebooks with legacy/mbr booting firmware and generic intel systems with mbr booting bios: https://github.com/hexdump0815/imagebuilder/blob/main/systems/chromebook_x86_mbr/readme.md
- intel chromebooks with uefi firmware and generic intel systems with uefi bios: https://github.com/hexdump0815/imagebuilder/blob/main/systems/chromebook_x86_uefi/readme.md
- intel gemini lake chromebooks without any alternative bios using the chromeos native way for booting: https://github.com/hexdump0815/imagebuilder/blob/main/systems/chromebook_octopus/readme.md
- odroid u3 (u3, u2, x2, x) devices: https://github.com/hexdump0815/imagebuilder/blob/main/systems/odroid_u3/readme.md
- odroid mc1 (mc1, xu3, xu4, hc1, hc2) devices: https://github.com/hexdump0815/imagebuilder/blob/main/systems/odroid_mc1/readme.md
- orbsmart s92, beelink r89 and similar rockchip rk3288 tv boxes: https://github.com/hexdump0815/imagebuilder/blob/main/systems/orbsmart_s92_beelink_r89/readme.md
- raspberry pi 3: https://github.com/hexdump0815/imagebuilder/blob/main/systems/raspberry_pi_3/readme.md
- raspberry pi 4: https://github.com/hexdump0815/imagebuilder/blob/main/systems/raspberry_pi_4/readme.md
- rockchip rk3288 devices: https://github.com/hexdump0815/imagebuilder/blob/main/systems/rockchip_rk3288/readme.md
- rockchip rk33xx devices and tv boxes: https://github.com/hexdump0815/imagebuilder/blob/main/systems/rockchip_rk33xx/readme.md

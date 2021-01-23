#!/bin/bash

echo "/opt/mesa-armv7l/lib/arm-linux-gnueabihf" > etc/ld.so.conf.d/aaa-mesa.conf

mv usr/lib/arm-linux-gnueabihf/dri usr/lib/arm-linux-gnueabihf/dri.org
ln -s /opt/mesa-armv7l/lib/arm-linux-gnueabihf/dri usr/lib/arm-linux-gnueabihf/dri
#!/bin/bash

echo "" >> etc/pulse/default.pa
echo "# required for working pulseaudio on nyan big - audio input does not yet work well" >> etc/pulse/default.pa
echo "load-module module-alsa-sink device=hw:1" >> etc/pulse/default.pa
echo "#load-module module-alsa-source device=hw:1" >> etc/pulse/default.pa

sed -i "s,LOGINUSERNAME,$LOGINUSERNAME,g" etc/systemd/system/resume_user_script.service

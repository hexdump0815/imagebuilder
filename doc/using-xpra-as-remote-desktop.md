# using xpra as remote desktop

## overview

xpra is a software which can be used to acess the desktop on one system from
another system which is very flexible and it performs very well even on slower
systems and with lower bandwith links by using different technologies. it can
be seen in some way as something like tmux or screen for xorg. more
information about it can be found here:

- https://xpra.org/
- https://github.com/Xpra-org/xpra

the following is mostly a dump of information and hints i have collected over
the years in the hope that it maybe will be useful for others as well. in
general xpra is not perfect, but might be a useful option similar to vnc, rdp
etc. in some situations.

## installation

the xpra package which is coming as part of debian or ubuntu is simply too old
to really be used - it lacks a lot of recent features and optimizations and is
most probably also not the best option from security perspective. the latest
available version of xpra can be installed via /scripts/install-xpra.sh and it
can also be removed again via /scripts/remove-xpra.sh. on the server side the
following line should be in /etc/X11/Xwrapper.config: "allowed_users=anybody"
(i'm not sure if this is still required or if there is anyway around it).

## starting it on the server side

xpra usually gets started as a regular user on the server system and in the
way it is used here (btw.: a lot of other ways to use it are possible like
seamless windows instead of the full desktop etc.) it will create a full xfce
based desktop session which one then can connect to from another system. the
session is alive as long as it is running and it is possible to connect or
disconnect to/from it as often as wanted without that having any effect on the
session itself. an example commandline to start a session could be:
```
xpra start-desktop :100 --start-child=xfce4-session --exit-with-children --xvfb='Xvfb -nolisten tcp -noreset +extension GLX +extension Composite -auth $XAUTHORITY -screen 0 1366x768x24' --start-via-proxy=no --systemd-run=no --file-transfer=no --printing=no --resize-display=yes --mdns=no --pulseaudio=yes --dbus-proxy=no --dbus-control=no --webcam=no > /tmp/start-xpra.log 2>&1
```
please check the documentation for the meaning of all the commandline options
used.

## starting it on the client side

on the client side it is now possible to connect to the running session via:
```
xpra --opengl=yes --encoding=rgb --key-shortcut=Shift+F8:toggle_fullscreen --desktop-fullscreen=yes --title="some title" attach ssh/someuser@somehost/100
```
somehost is the hostname where the server runs and someuser the xpra server
start user.

this will start the client in full screen mode and it is possible to leave the
full screen mode via shift-f8 (shift-f11 by default, but chromebooks for
instance to have an f11 key usually, thus the change to f8). if the client has
a proper puseaudio audio setup the session should automatically connect to it
and route audio output from within the session to the audio output of the
client.

## notes

- it basically works ok, but latency might be a problem, especially for slower
  systems and lower network bandwidth
- it is also possible to run server and client on the same system, so that one
  can for instance work on a desktop system and at some point disconnect with
the local client and reconnect remotely afterwards to the same session used
before on the desktop system - to make audio work in such a scenario the env
variable "XPRA_ALLOW_SOUND_LOOP=1" should be set and exported before starting
xpra on server and on client side.
- it looks like in some situations scroll wheels scroll too fast in firefox in
  an xpra session - setting something like
"mousewheel.default.delta_multiplier_x = 33" (maybe similar for y and z for
more complex mice?) in "about:config" of firefox seems to help
- by default xpra is using the Xvfb virtual xorg server which in the version
  provided by most distributions does not support glamor required for opengl
gpu acceleration even if there is a working gpu setup on the server side (this
might be fixed in the latest dev versions of xvfb - not really sure if this is
the case and supposed to be fully working) - one possible workaround (hack)
which worked for me was to use xorgxrdp as xserver for xpra which is also a
virtual xorg server which supports glamor and thus gpu accel on server side
(but is not really easy to setup in such a scenario) - some inspiration for
this can be found here:
  - https://github.com/hexdump0815/sonaremin-ng/blob/78ea2c781b7429572f71298da31f5033f834fc48/files/extra-files/home/sonaremin/bin/start-xpra.sh#L21
  - https://github.com/hexdump0815/sonaremin-ng/tree/78ea2c781b7429572f71298da31f5033f834fc48/files/extra-files/etc/X11
- off topic, but maybe interesting for running an xorg session out of a docker container: https://github.com/mviereck/x11docker

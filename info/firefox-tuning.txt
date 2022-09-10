# some options to improve firefox usage on smaller systems

the below mentioned values can be changed in firefox by opening "about:config"
as url in the browser.

## reduce sd/emmc/ssd disk wear

```
browser.sessionstore.interval = 300000 (= 5min - default is 15000 = 15 sec)
```
by default firefox is writing all of its session information to disk every 15
seconds - this creates a lot of disk writes (in the range of tens of gb per
day during normal firefox usage) which will wear solid state based storage
with a limited number of write cycles quite a bit and will reduce their life
time. to work around this problem the sessionstore interval can be increased
to like 5 minutes as given in the example above to reduce those writes quite a
bit. it is important to keep in mind that in this case everything done in the
browser during the last 5 minutes will be lost in case of a browser crash.

## reduce memory usage

```
browser.sessionstore.max_tabs_undo = 10 (default is 25)
browser.sessionstore.max_windows_undo = 1 (default is 3)
```
firefox by default keeps information about closed tabs and windows which is
using memory. by reducing the number of tabs and windows for which for which
this information is still kept around the memory usage of the browser might be
used a bit.

## avoid the browser being detected as mobile version on some systems

```
general.useragent.override = Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101 Firefox/102.0
```
on some systems (armv7l for instance) the browser is detected as the mobile
version instead of as desktop version of it which results in non optimal
rendering of web pages for desktop usage. the reason for this is that web
pages might evaluate the agent string of the browser to decide if it is a
desktop or a mobile system to render the pages for - sadly quite a few pages
assume armv7l devices as android devices and thus trigger the mobile version
of the pages. this can be worked around by setting a different useragent value
(like for aarch64) which hopefully will not trigger this behaviour.


## force enable opengl usage
```
layers.gpu-process.force-enabled = 1
```
maybe with panfrost enabled it works better if firefox gets forced to opengl
mode via layers.acceleration.force-enabled = true in about:config

see also: https://oftc.irclog.whitequark.org/panfrost/2022-08-27#31297793

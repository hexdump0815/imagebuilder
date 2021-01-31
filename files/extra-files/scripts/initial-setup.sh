#!/bin/bash

dpkg-reconfigure keyboard-configuration
# activate new setting on the console if virtual console is used
setupcon
dpkg-reconfigure tzdata
dpkg-reconfigure locales

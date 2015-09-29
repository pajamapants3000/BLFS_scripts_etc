#!/bin/bash -ev
#
# Installation Script
# Additional Config for Shadow-4.2.1
# Check for previous installation:
#
as_root cp -v files/other /etc/pam.d/
[ -f /etc/login.access ] && as_root mv -v /etc/login.access{,.NOUSE}
[ -f /etc/limits ] && as_root mv -v /etc/limits{,.NOUSE}
#
###################################################
# Done with Shadow, whew!
###################################################
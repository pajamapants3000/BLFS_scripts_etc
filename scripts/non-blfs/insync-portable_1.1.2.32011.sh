#!/bin/bash -ev
# Installation script for insync-portable
# Check for previous installation:
PROCEED="yes"
grep insync-portable /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://s.insynchq.com/builds/insync-portable_1.1.2.32011_amd64.tar.bz2
#
tar -xvf insync-portable_1.1.2.32011_amd64.tar.bz2
mv -v insync-portable ~/insync-portable
#
# Create convenient executables:
#
tee > ~/bin/insync-start << "EOF"
#!/bin/bash
cd ~/insync-portable
./insync-portable start
EOF
tee > ~/bin/insync-stop << "EOF"
#!/bin/bash
cd ~/insync-portable
./insync-portable quit
EOF
tee > ~/bin/insync-status << "EOF"
#!/bin/bash
cd ~/insync-portable
./insync-portable get_status
EOF
chmod -v +x ~/bin/insync-start
chmod -v +x ~/bin/insync-stop
chmod -v +x ~/bin/insync-status
#
# Add to installed list for this computer:
echo "insync-portable-1.1.2.32011" >> /list-$CHRISTENED"-"$SURNAME
#
# Follow-up
# go to http://goo.gl/kTvy0y (needs javascript-enabled browser :( firefox ok
#    but not links or even links -g. Others? Other way?))
# Log in to desired google account
# Obtain (long!) AUTH code
# Copy in to vim, create script - easiest way without copy/paste to terminal
# Script:
##!/bin/bash -ev
#./insync-portable add_account AUTH_CODE PATH
#
# ...where PATH is the folder where you'd like to sync to. Folder need not (must
#    not?) exist, but I'm pretty sure the subfolder must.
# That's it!
#
###################################################
#!/bin/bash
# Installation script for dreampie - git source
# Dependencies: Python-2, gtk (2,3?), pygtksourceview
#####################################################################
pushd ~/git_repos
git clone https://github.com/noamraph/dreampie.git
cd dreampie
as_root python2 setup.py install
popd
as_root rm -rf ~/git_repos/dreampie
#
cat >> ~/bin/dreampi3 << "EOF"
#!/bin/bash
# Runs dreampie with python3 as interpreter
dreampie python3
EOF
chmod -v +x ~/bin/dreampi3
#
# Add to list of installed programs on this system
echo "dreampie" >> /list-$CHRISTENED"-"$SURNAME
#
#####################################################################

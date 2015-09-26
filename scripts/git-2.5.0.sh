#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for git-2.5.0
#
# Dependencies
#**************
# Begin Required
# End Required
# Begin Recommended
#curl-7.44.0
#openssl-1.0.2d
#python-2.7.10
# End Recommended
# Begin Optional
#pcre-8.37
#subversion-1.8.13
#tk-8.6.4
#valgrind-3.10.1
#xmlto-0.0.26
#asciidoc
#asciidoctor
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep git-2.5.0 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget https://www.kernel.org/pub/software/scm/git/git-2.5.0.tar.xz
# FTP/alt Download:
#wget ftp://ftp.kernel.org/pub/software/scm/git/git-2.5.0.tar.xz
#
# md5sum:
echo "f108b475a0aa30e9587be4295ab0bb09 git-2.5.0.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
# Additional doc downloads
wget https://www.kernel.org/pub/software/scm/git/git-manpages-2.5.0.tar.xz
wget https://www.kernel.org/pub/software/scm/git/git-htmldocs-2.5.0.tar.xz
tar -xvf git-2.5.0.tar.xz
cd git-2.5.0
./configure --prefix=/usr --with-gitconfig=/etc/gitconfig
make
# with asciidoc, build html docs
#make html
# with asciidoc and xmlto, build man pages
#make man
# Test:
make test
#
as_root make install
#
# with asciidoc, build html docs
#make htmldir=/usr/share/doc/git-2.5.0 install-html
# with asciidoc and xmlto, build man pages
#make install-man
#
# If man pages were downloaded
as_root tar -xf ../git-manpages-2.5.0.tar.xz \
    -C /usr/share/man --no-same-owner --no-overwrite-dir
# If html docs were downloaded
as_root mkdir -vp   /usr/share/doc/git-2.5.0
as_root tar   -xf   ../git-htmldocs-2.5.0.tar.xz \
      -C    /usr/share/doc/git-2.5.0 --no-same-owner --no-overwrite-dir
find        /usr/share/doc/git-2.5.0 -type d -exec sudo chmod 755 {} \;
find        /usr/share/doc/git-2.5.0 -type f -exec sudo chmod 644 {} \;
# For both doc downloads
as_root mkdir -vp /usr/share/doc/git-2.5.0/man-pages/{html,text}
as_root mv        /usr/share/doc/git-2.5.0/{git*.txt,man-pages/text}
as_root mv        /usr/share/doc/git-2.5.0/{git*.,index.,man-pages/}html
as_root mkdir -vp /usr/share/doc/git-2.5.0/technical/{html,text}
as_root mv        /usr/share/doc/git-2.5.0/technical/{*.txt,text}
as_root mv        /usr/share/doc/git-2.5.0/technical/{*.,}html
as_root mkdir -vp /usr/share/doc/git-2.5.0/howto/{html,text}
as_root mv        /usr/share/doc/git-2.5.0/howto/{*.txt,text}
as_root mv        /usr/share/doc/git-2.5.0/howto/{*.,}html
#
# bash/zsh completions
[ -e /etc/bash_completion.d ] || sudo mkdir -v /etc/bash_completion.d
sudo cp -v contrib/completion/git-completion.bash /etc/bash_completion.d
[ -e /etc/zsh_completion.d ] || sudo mkdir -v /etc/zsh_completion.d
sudo cp -v contrib/completion/git-completion.zsh /etc/zsh_completion.d
# Script to put git status in terminal prompt
[ -e ${HOME}/bin ] || mkdir -v ${HOME}/bin
cp -v contrib/completion/git-prompt ${HOME}/bin/
#
cd ..
as_root rm -rf git-2.5.0
#
# Add to installed list for this computer:
echo "git-2.5.0" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################

#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for libreoffice-5.0.0.5
#
# Dependencies
#**************
# Begin Required
#archive__zip-1.49
#unzip-6.0
#wget-1.16.3
#which-2.21
#zip-3.0
# End Required
# Begin Recommended
#boost-1.58.0
#clucene-2.3.3.4
#cups-2.0.4
#curl-7.43.0
#dbus_glib-0.104
#libjpeg_turbo-1.4.1
#glu-9.0.0
#graphite2-1.3.0
#gst_plugins_base-1.4.5
#gtk+-2.24.28
#harfbuzz-1.0.1
#icu-55.1
#little cms-2.7
#librsvg-2.40.10
#libxml2-2.9.2
#libxslt-1.1.28
#mesa-10.6.3
#neon-0.30.1
#npapi_sdk-0.27.2
#nss-3.19.3
#openldap-2.4.41
#openssl-1.0.2d
#poppler-0.34.0
#python-3.4.3
#redland-1.0.17
#unixodbc-2.3.2
# End Recommended
# Begin Optional
#avahi-0.6.31
#bluez-5.32
#desktop_file_utils-0.22
#doxygen-1.8.10
#gdb-7.9.1
#gtk+-3.16.6
#kdelibs-4.14.10
#libatomic_ops-7.4.2
#mariadb-10.0.20 or mysql
#mit kerberos v5-1.13.2
#openjdk-1.8.0.45
#postgresql-9.4.4
#sane-1.0.24
#vlc-2.2.1
#coinmp
#cppunit
#firebird
#glew
#hamcrest
#hunspell
#hyphen
#iwyu
#libabw
#libcdr
#libcmis
#libebook
#libexttextcat
#libfreehand
#liblangtag
#libmspub
#libmwaw
#libodfgen
#libpagemaker
#librevenge
#libvisio
#libwpd
#libwpg
#libwps
#lp_solve
#mdds
#mythes
#ogl_math
#opencollada
#orcus
#vigra
#zenity
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep libreoffice-5.0.0.5 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://download.documentfoundation.org/libreoffice/src/4.4.5/libreoffice-5.0.0.5.tar.xz
# md5sum:
echo "9bcb92fc06b3e2676a841420079598bd libreoffice-5.0.0.5.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
# Dictionaries download:
wget http://download.documentfoundation.org/libreoffice/src/4.4.5/libreoffice-dictionaries-4.4.5.2.tar.xz
# md5sum:
echo "84ff615f57ff189ca5e1bb61480e271d libreoffice-dictionaries-4.4.5.2.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
# Help files download:
wget http://download.documentfoundation.org/libreoffice/src/4.4.5/libreoffice-help-4.4.5.2.tar.xz
# md5sum:
echo "fefc1e3b500a4064f19245e4702bbb46 libreoffice-help-4.4.5.2.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
# Translations ownload:
wget http://download.documentfoundation.org/libreoffice/src/4.4.5/libreoffice-translations-4.4.5.2.tar.xz
# md5sum:
echo "4c82bc306d11d2bedf27780656300af3 libreoffice-translations-4.4.5.2.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xf libreoffice-5.0.0.5.tar.xz --no-overwrite-dir
cd libreoffice-5.0.0.5
install -dm755 external/tarballs
ln -sv ../../../libreoffice-dictionaries-4.4.5.2.tar.xz external/tarballs/
ln -sv ../../../libreoffice-help-4.4.5.2.tar.xz         external/tarballs/
ln -sv ../../../libreoffice-translations-4.4.5.2.tar.xz external/tarballs/
export LO_PREFIX=/opt/libreoffice-5.0.0.5
sed -e "/gzip -f/d"   \
    -e "s|.1.gz|.1|g" \
    -i bin/distro-install-desktop-integration
sed -e "/distro-install-file-lists/d" -i Makefile.in
sed -e "/ustrbuf/a #include <algorithm>" \
    -i svl/source/misc/gridprinter.cxx
chmod -v +x bin/unpack-sources

if ! (cat /list-$CHRISTENED"-"$SURNAME | grep "gtk+-2" > /dev/null)
./autogen.sh --prefix=$LO_PREFIX         \
             --sysconfdir=/etc           \
             --with-vendor="BLFS"        \
             --with-lang="en-US"         \
             --with-help                 \
             --with-myspell-dicts        \
             --with-alloc=system         \
             --without-java              \
             --without-system-dicts      \
             --disable-gconf             \
             --disable-odk               \
             --disable-postgresql-sdbc   \
             --enable-release-build=yes  \
             --enable-python=system      \
             --with-system-boost         \
             --with-system-clucene       \
             --with-system-cairo         \
             --with-system-curl          \
             --with-system-expat         \
             --with-system-graphite      \
             --with-system-harfbuzz      \
             --with-system-icu           \
             --with-system-jpeg          \
             --with-system-lcms2         \
             --with-system-libpng        \
             --with-system-libxml        \
             --with-system-mesa-headers  \
             --with-system-neon          \
             --with-system-npapi-headers \
             --with-system-nss           \
             --with-system-odbc          \
             --with-system-openldap      \
             --with-system-openssl       \
             --with-system-poppler       \
             --with-system-redland       \
             --with-system-zlib          \
             --with-parallelism=$(getconf _NPROCESSORS_ONLN)
elif ! (cat /list-$CHRISTENED"-"$SURNAME | grep "gtk+-3" > /dev/null)
./autogen.sh --prefix=$LO_PREFIX         \
             --sysconfdir=/etc           \
             --with-vendor="BLFS"        \
             --with-lang="en-US"         \
             --with-help                 \
             --with-myspell-dicts        \
             --with-alloc=system         \
             --without-java              \
             --without-system-dicts      \
             --disable-gconf             \
             --disable-odk               \
             --disable-postgresql-sdbc   \
             --enable-release-build=yes  \
             --enable-python=system      \
             --with-system-boost         \
             --with-system-clucene       \
             --with-system-cairo         \
             --with-system-curl          \
             --with-system-expat         \
             --with-system-graphite      \
             --with-system-harfbuzz      \
             --with-system-icu           \
             --with-system-jpeg          \
             --with-system-lcms2         \
             --with-system-libpng        \
             --with-system-libxml        \
             --with-system-mesa-headers  \
             --with-system-neon          \
             --with-system-npapi-headers \
             --with-system-nss           \
             --with-system-odbc          \
             --with-system-openldap      \
             --with-system-openssl       \
             --with-system-poppler       \
             --with-system-redland       \
             --with-system-zlib          \
             --enable-gtk3               \
             --with-parallelism=$(getconf _NPROCESSORS_ONLN)
elif ! (cat /list-$CHRISTENED"-"$SURNAME | grep kdelibs > /dev/null)
./autogen.sh --prefix=$LO_PREFIX         \
             --sysconfdir=/etc           \
             --with-vendor="BLFS"        \
             --with-lang="en-US"         \
             --with-help                 \
             --with-myspell-dicts        \
             --with-alloc=system         \
             --without-java              \
             --without-system-dicts      \
             --disable-gconf             \
             --disable-odk               \
             --disable-postgresql-sdbc   \
             --enable-release-build=yes  \
             --enable-python=system      \
             --with-system-boost         \
             --with-system-clucene       \
             --with-system-cairo         \
             --with-system-curl          \
             --with-system-expat         \
             --with-system-graphite      \
             --with-system-harfbuzz      \
             --with-system-icu           \
             --with-system-jpeg          \
             --with-system-lcms2         \
             --with-system-libpng        \
             --with-system-libxml        \
             --with-system-mesa-headers  \
             --with-system-neon          \
             --with-system-npapi-headers \
             --with-system-nss           \
             --with-system-odbc          \
             --with-system-openldap      \
             --with-system-openssl       \
             --with-system-poppler       \
             --with-system-redland       \
             --with-system-zlib          \
             --enable-kde4               \
             --with-parallelism=$(getconf _NPROCESSORS_ONLN)
else
    echo "No graphical interface installed (gtk2, gtk3, or kdelibs)"
    echo "Install one of these and then try again"
    ( exit 1 )
fi
# To run unit tests, replace make build with make
make build
#
as_root make distro-pack-install
as_root install -v -m755 -d $LO_PREFIX/share/appdata
as_root install -v -m644    sysui/desktop/appstream-appdata/*.xml \
                    $LO_PREFIX/share/appdata
#
if [ "$LO_PREFIX" != "/usr" ]; then
  # This symlink is necessary for the desktop menu entries
  as_root ln -svf $LO_PREFIX/lib/libreoffice/program/soffice /usr/bin/libreoffice
  # Icons
  for i in $LO_PREFIX/share/icons/hicolor/32x32/apps/*; do
    as_root ln -svf $i /usr/share/pixmaps
  done
  # Desktop menu entries
  for i in $LO_PREFIX/lib/libreoffice/share/xdg/*; do
    as_root ln -svf $i /usr/share/applications/libreoffice-$(basename $i)
  done
  # Man pages
  for i in $LO_PREFIX/share/man/man1/*; do
    as_root ln -svf $i /usr/share/man/man1/
  done 
  unset i
fi
as_root update-desktop-database
cd ..
as_root rm -rf libreoffice-5.0.0.5
#
# Add to installed list for this computer:
echo "libreoffice-5.0.0.5" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################

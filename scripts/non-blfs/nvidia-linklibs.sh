#!/bin/bash -ev
# File: nvidia-linklibs.sh
# Purpose: Activates the desired version of the nvidia graphics driver by
#+creating symlinks, replacing any previously existing ones, where the system
#+will use them
PREFICKS=/usr
VERSION=361.18
for _lib in $(find ${PREFICKS}/lib/nvidia/${VERSION} -name '*.so*' |
              grep -v 'xorg/' | grep -v 'vdpau'); do
    _soname=$(readelf -d "${_lib}" | grep -Po 'SONAME.*: \[\K[^]]*' || true)
    _base=$(echo ${_soname} | sed -r 's/(.*).so.*/\1.so/')
    as_root ln -sfv ${PREFICKS}/lib/nvidia/${VERSION}/${_lib} \
            ${PREFICKS}/lib/_soname
    as_root ln -sfv ${PREFICKS}/lib/_soname ${PREFICKS}/lib/_base
done
for _lib in $(find ${PREFICKS}/lib/nvidia/${VERSION}/vdpau -name '*.so*'); do
    _soname=$(readelf -d "${_lib}" | grep -Po 'SONAME.*: \[\K[^]]*' || true)
    _base=$(echo ${_soname} | sed -r 's/(.*).so.*/\1.so/')
    as_root ln -sfv ${PREFICKS}/lib/nvidia/${VERSION}/${_lib} \
            ${PREFICKS}/lib/vdpau/_soname
    as_root ln -sfv ${PREFICKS}/lib/vdpau/_soname ${PREFICKS}/lib/vdpau/_base
done
as_root ln -sfv ${PREFICKS}/lib/nvidia/${VERSION}/xorg/modules/extensions/* \
        ${PREFICKS}/lib/xorg/modules/extensions/
as_root ln -sfv libglx.so.${VERSION} \
        ${PREFICKS}/lib/xorg/modules/extensions/libglx.so.1
as_root ln -sfv libglx.so.1 \
        ${PREFICKS}/lib/xorg/modules/extensions/libglx.so
as_root ln -sfv ${PREFICKS}/lib/nvidia/${VERSION}/xorg/modules/drivers/* \
        ${PREFICKS}/lib/xorg/modules/drivers/

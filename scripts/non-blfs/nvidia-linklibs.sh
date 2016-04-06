#!/bin/bash -ev
# File: nvidia-linklibs.sh
# Purpose: Activates the desired version of the nvidia graphics driver by
#+creating symlinks, replacing any previously existing ones, where the system
#+will use them
PREFICKS=/usr
VERSION=361.28
for _lib in $(find ${PREFICKS}/lib/nvidia/${VERSION} -name '*.so*' |
              grep -v 'xorg/' | grep -v 'vdpau'); do
    _soname=$(readelf -d "${_lib}" | grep -Po 'SONAME.*: \[\K[^]]*' || true)
    _base=$(echo ${_soname} | sed -r 's/(.*).so.*/\1.so/')
    [ -d /home/tommy/nv_bak ] || mkdir -v /home/tommy/nv_bak
    cp -v ${PREFICKS}/lib/${_soname} /home/tommy/nv_bak/
    cp -v ${PREFICKS}/lib/${_base} /home/tommy/nv_bak/
    as_root ln -sfv ${PREFICKS}/lib/nvidia/${VERSION}/${_lib} \
            ${PREFICKS}/lib/${_soname}
    as_root ln -sfv ${PREFICKS}/lib/${_soname} ${PREFICKS}/lib/${_base}
done
for _lib in $(find ${PREFICKS}/lib/nvidia/${VERSION}/vdpau -name '*.so*'); do
    _soname=$(readelf -d "${_lib}" | grep -Po 'SONAME.*: \[\K[^]]*' || true)
    _base=$(echo ${_soname} | sed -r 's/(.*).so.*/\1.so/')
    [ -d /home/tommy/nv_bak/vdpau ] || mkdir -v /home/tommy/nv_bak/vdpau
    cp -v ${PREFICKS}/lib/vdpau/${_soname} /home/tommy/nv_bak/vdpau/
    cp -v ${PREFICKS}/lib/vdpau/${_base} /home/tommy/nv_bak/vdpau/
    as_root ln -sfv ${PREFICKS}/lib/nvidia/${VERSION}/${_lib} \
            ${PREFICKS}/lib/vdpau/${_soname}
    as_root ln -sfv ${PREFICKS}/lib/vdpau/${_soname} ${PREFICKS}/lib/vdpau/${_base}
done
for dir in extensions drivers; do
    for file in $(
         ls ${PREFICKS}/lib/nvidia/${VERSION}/xorg/modules/${dir}/
                 ); do
        if [ -f ${PREFICKS}/lib/xorg/modules/${dir}/${file} ]; then
            mv -v ${PREFICKS}/lib/xorg/modules/${dir}/${file} \
                ${PREFICKS}/lib/xorg/modules/${dir}/${file}.bak
        fi
        as_root ln -sfv $file \
                ${PREFICKS}/lib/xorg/modules/extensions/${file}
    done
done
as_root ln -sfv libglx.so.${VERSION} \
        ${PREFICKS}/lib/xorg/modules/extensions/libglx.so.1
as_root ln -sfv libglx.so.1 \
        ${PREFICKS}/lib/xorg/modules/extensions/libglx.so
as_root ln -sfv nvidia_drv.so.${VERSION}
        ${PREFICKS}/lib/xorg/modules/drivers/nvidia_drv.so


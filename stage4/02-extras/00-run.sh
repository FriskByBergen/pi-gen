#!/bin/bash -e

ln -sf pip3 ${ROOTFS_DIR}/usr/bin/pip-3.2

install -v -o 1000 -g 1000 -d "${ROOTFS_DIR}/home/pi/Documents"

#Alacarte fixes
install -v -o 1000 -g 1000 -d "${ROOTFS_DIR}/home/pi/.local"
install -v -o 1000 -g 1000 -d "${ROOTFS_DIR}/home/pi/.local/share"
install -v -o 1000 -g 1000 -d "${ROOTFS_DIR}/home/pi/.local/share/applications"
install -v -o 1000 -g 1000 -d "${ROOTFS_DIR}/home/pi/.local/share/desktop-directories"

# Remove the dirt old jessie pip, replace it with our own.
pip install --ignore-installed --prefix=${ROOTFS_DIR}/usr pip
mv ${ROOTFS_DIR}/usr/lib/python2.7/site-packages/* ${ROOTFS_DIR}/usr/lib/python2.7/dist-packages/

pip install --ignore-installed --prefix=${ROOTFS_DIR}/usr/local rpiparticle
# We do not want anything in site-packages as it is not in our path.
mv ${ROOTFS_DIR}/usr/local/lib/python2.7/site-packages/* ${ROOTFS_DIR}/usr/local/lib/python2.7/dist-packages/

# Manually enable all friskby services
ln -sf /usr/local/lib/systemd/system/friskby.service ${ROOTFS_DIR}/etc/systemd/system/getty.target.wants/friskby.service
ln -sf /usr/local/lib/systemd/system/friskby-controlpanel.service ${ROOTFS_DIR}/etc/systemd/system/getty.target.wants/friskby-controlpanel.service
ln -sf /usr/local/lib/systemd/system/friskby-submitter.service ${ROOTFS_DIR}/etc/systemd/system/getty.target.wants/friskby-submitter.service
ln -sf /usr/local/lib/systemd/system/friskby-sampler.service ${ROOTFS_DIR}/etc/systemd/system/getty.target.wants/friskby-sampler.service

install -m 755 files/splash.png ${ROOTFS_DIR}/usr/share/plymouth/themes/pix/

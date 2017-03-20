#!/bin/sh
make uci
make uci_install
make device
make device_install
make cwmp_install
cp tr069.sh /sbin/tr069 -rf

#make clean
#make distclean

CROSS_COMPILE = 
AS		= $(CROSS_COMPILE)as
LD		= $(CROSS_COMPILE)ld
CC		= $(CROSS_COMPILE)gcc
CPP		= $(CC) -E
AR		= $(CROSS_COMPILE)ar
NM		= $(CROSS_COMPILE)nm

STRIP		= $(CROSS_COMPILE)strip
OBJCOPY		= $(CROSS_COMPILE)objcopy
OBJDUMP		= $(CROSS_COMPILE)objdump

export AS LD CC CPP AR NM
export STRIP OBJCOPY OBJDUMP

CFLAGS := -Werror -O2 -g -D_GNU_SOURCE
CFLAGS += -I $(shell pwd)/include

LDFLAGS := -luci -lcurl 

export CFLAGS LDFLAGS

TOPDIR := $(shell pwd)
export TOPDIR

TARGET := device.so

obj-y += src/

uci :
	#############1. make uci.so #####################
	make -C  $(shell pwd)/uci-0.1/

uci_install :
	#############2. install uci library and include and bin files #####################
	cp $(shell pwd)/uci-0.1/libuci.so.0.1 /usr/lib/libuci.so.0.1
	ln -sf /usr/lib/libuci.so.0.1 /usr/lib/libuci.so
	cp $(shell pwd)/uci-0.1/uci.h $(shell pwd)/uci-0.1/uci_config.h $(shell pwd)/uci-0.1/uci_internal.h /usr/include/
	cp $(shell pwd)/uci-0.1/uci /usr/bin/
device : 
	#############3. make device.so #####################
	make -C $(shell pwd)/ -f $(TOPDIR)/Makefile.build
	$(CC) -o $(TARGET) -shared -fPIC built-in.o $(LDFLAGS)

device_install:
	#######4. install device library and config  for tr069 running test ##################
	cp etc_config/* /etc/config/ -rf
	cp device.so /usr/lib/
cwmp_install:
	#######5. install cwmp core ##################
	cp cwmp_x86/cwmp /usr/bin/ -rf
	cp tr069.sh /sbin/tr069 -rf

.PHONY: clean
clean:
	rm -f $(shell find -name "*.o")
	rm -f $(shell find -name "*.d")
	rm -f $(TARGET)
	make clean -C $(shell pwd)/uci-0.1/
	
.PHONY: distclean
distclean:
	##########1. clear device and uci make #################
	rm -f $(shell find -name "*.o")
	rm -f $(shell find -name "*.d")
	rm -f $(TARGET)
	make clean -C $(shell pwd)/uci-0.1/
	##########2. remove uci install #################
	rm -rf /usr/lib/libuci.so.0.1 /usr/lib/libuci.so
	rm -rf /usr/include/uci_internal.h /usr/include/uci_config.h  /usr/include/uci.h
	rm -rf /usr/bin/uci
	##########3. remove device install #################
	rm -rf /etc/config/*
	rm -rf /usr/lib/device.so	
	##########4. remove cwmp core install #################
	rm -rf /usr/bin/cwmp

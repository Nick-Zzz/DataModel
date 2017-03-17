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

# we are on ubuntu12.04 and use gcc version is  4.6.3
CFLAGS := -Werror -O2 -g -D_GNU_SOURCE
#CFLAGS += -D__USE_XOPEN  -D_GNU_SOURCE 

CFLAGS += -I $(shell pwd)/include

#LDFLAGS := -luci -lcurl -leboxresolv
LDFLAGS := -luci -lcurl 

export CFLAGS LDFLAGS

TOPDIR := $(shell pwd)
export TOPDIR

TARGET := device.so


obj-y += src/



all : 
	make -C ./ -f $(TOPDIR)/Makefile.build
	$(CC) -o $(TARGET) -shared -fPIC built-in.o $(LDFLAGS)
	make -C  ./uci-0.1/

#######install your path##################
install:
	cp etc_config/* /etc/config/ -rf
	cp device.so /usr/lib/
	cp ./uci-0.1/libuci.so /usr/lib/ 
	cp ./uci-0.1/uci /usr/bin/
.PHONY: clean
clean:
	rm -f $(shell find -name "*.o")
	rm -f $(TARGET)
	make clean -C ./uci-0.1/
	
.PHONY: distclean
distclean:
	rm -f $(shell find -name "*.o")
	rm -f $(shell find -name "*.d")
	rm -f $(TARGET)
	make clean -C ./uci-0.1/
	

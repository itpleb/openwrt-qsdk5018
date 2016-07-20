#
# Copyright (c) 2015 The Linux Foundation. All rights reserved.
#

define Profile/QSDK_Base
        PACKAGES:=luci uhttpd kmod-ipt-nathelper-extra luci-app-upnp mcproxy \
          kmod-ipt-nathelper-rtsp kmod-ipv6 \
          quagga quagga-ripd quagga-zebra quagga-watchquagga rp-pppoe-relay \
          -dnsmasq dnsmasq-dhcpv6 radvd wide-dhcpv6-client bridge \
          luci-app-ddns ddns-scripts
endef

IOE_BASE:=luci uhttpd luci-app-upnp mcproxy rp-pppoe-relay \
	  -dnsmasq dnsmasq-dhcpv6 radvd wide-dhcpv6-client bridge \
	  -swconfig luci-app-ddns ddns-scripts luci-app-qos \
	  kmod-nf-nathelper-extra kmod-ipt-nathelper-rtsp kmod-ipv6 \
	  kmod-usb2 kmod-i2c-gpio-custom kmod-button-hotplug

STORAGE:=kmod-scsi-core kmod-usb-storage \
	 kmod-fs-msdos kmod-fs-ntfs kmod-fs-vfat \
	 kmod-nls-cp437 kmod-nls-iso8859-1 \
	 mdadm ntfs-3g e2fsprogs fdisk mkdosfs

TEST_TOOLS:=sysstat devmem2 ethtool i2c-tools ip ip6tables

ALLJOYN:=alljoyn alljoyn-about alljoyn-c alljoyn-config \
	 alljoyn-controlpanel alljoyn-notification \
	 alljoyn-services_common

WIFI_OPEN:=-kmod-ath5k -kmod-qca-ath -kmod-qca-ath9k -kmod-qca-ath10k \
	   kmod-ath kmod-ath9k hostapd hostapd-utils iwinfo wpa-supplicant-p2p \
	   wpa-cli wireless-tools -wpad-mini

BLUETOOTH:=bluez-daemon kmod-bluetooth usbutils

define Profile/QSDK_IOE_SB
	NAME:=Qualcomm-Atheros SDK IoE Single Band Profile
	PACKAGES:=$(IOE_BASE) $(TEST_TOOLS) $(ALLJOYN) $(WIFI_OPEN) \
		  qca-legacy-uboot-ap143-16M qca-legacy-uboot-ap143-32M \
		  qca-legacy-uboot-cus531-16M qca-legacy-uboot-cus531-dual \
		  qca-legacy-uboot-cus531-32M qca-legacy-uboot-cus531-nand \
		  qca-legacy-uboot-cus532k
endef

define Profile/QSDK_IoE_SB/Description
	QSDK IoE SB package set configuration.
	Enables WiFi 2.4G open source packages
endef

define Profile/QSDK_IOE_DBPAN
	NAME:=Qualcomm-Atheros SDK IoE Dual Band and Personal Area Network Profile
	PACKAGES:=$(IOE_BASE) $(TEST_TOOLS) $(ALLJOYN) $(WIFI_OPEN) $(BLUETOOTH) \
		  qca-legacy-uboot-cus531mp3-nand \
		  kmod-usb-serial kmod-usb-serial-pl2303 kmod-ath10k
endef

define Profile/QSDK_IoE_DBPAN/Description
	QSDK IoE DBPAN package set configuration.
	Enables WiFi 2.4G, 5G, Bluetooth open source packages
endef

$(eval $(call Profile,QSDK_IOE_SB))
$(eval $(call Profile,QSDK_IOE_DBPAN))

define Profile/QSDK_Open_Router
        $(Profile/QSDK_Base)
        $(Profile/QSDK_Test)
        NAME:=Qualcomm-Atheros SDK Open Router Profile
        PACKAGES+= kmod-ath9k -kmod-ath5k kmod-ath -wpad-mini $(STORAGE) \
          hostapd hostapd-utils iwinfo kmod-ath10k kmod-usb2 luci-app-qos \
          wireless-tools wpa-supplicant-p2p wpa-cli qca-legacy-uboot-ap121 \
          qca-legacy-uboot-ap143-16M qca-legacy-uboot-ap152-16M
endef

define Profile/QSDK_Open_Router/Description
  QSDK Open Router package set configuration.
  This profile includes only open source packages and is designed to fit in a 16M flash. It supports:
  - Bridging and routing networking
  - LuCI web configuration interface
  - USB hard drive support
  - IPv4/IPv6
  - DynDns
  - Integrated 11abgn support using the ath9k/ath10k driver
endef
$(eval $(call Profile,QSDK_Open_Router))

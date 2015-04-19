ARCHS = armv6 armv7 arm64
THEOS_DEVICE_IP = 192.168.0.7
PACKAGE_VERSION = $(THEOS_PACKAGE_BASE_VERSION)

BUNDLE_NAME = LocalSSH
LocalSSH_FILES = Switch.x
LocalSSH_FRAMEWORKS = UIKit
LocalSSH_LIBRARIES = flipswitch
LocalSSH_INSTALL_PATH = /Library/Switches

TOOL_NAME = localssh
localssh_FILES = main.mm
localssh_LIBRARIES = flipswitch

TWEAK_NAME = DisableLocalSSH
DisableLocalSSH_FILES = Tweak.xm
DisableLocalSSH_LIBRARIES = flipswitch
DisableLocalSSH_FRAMEWORKS = UIKit

include theos/makefiles/common.mk
include $(THEOS_MAKE_PATH)/bundle.mk
include $(THEOS_MAKE_PATH)/tool.mk
include $(THEOS_MAKE_PATH)/tweak.mk

before-package::
	sudo chown -R root:wheel $(THEOS_STAGING_DIR)
	sudo chmod -R 755 $(THEOS_STAGING_DIR)
	sudo chmod 644 $(THEOS_STAGING_DIR)/etc/services.swp
	sudo chmod 644 $(THEOS_STAGING_DIR)/Library/LaunchDaemons/com.openssh.sshd.plist.swp
	sudo chmod 666 $(THEOS_STAGING_DIR)/Library/Switches/LocalSSH.bundle/*.pdf
	sudo chmod 4755 $(THEOS_STAGING_DIR)/usr/bin/localssh

after-install::
	install.exec "killall -9 backboardd"
	sudo rm -rf _
	rm -rf .obj
	rm -rf obj
	rm -rf .theos
#	rm -rf *.deb
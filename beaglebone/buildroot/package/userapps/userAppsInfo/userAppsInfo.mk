################################################################################
#
# userAppsInfo
#
################################################################################

USERAPPSINFO_VERSION = 1.0
USERAPPSINFO_SITE = $(CURDIR)/../../../apps/userAppsInfo/src
USERAPPSINFO_SITE_METHOD = local
define USERAPPSINFO_BUILD_CMDS
	$(MAKE) CROSS_COMPILE=$(TARGET_CROSS) -C $(@D)
endef

define USERAPPSINFO_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/userAppsInfo $(TARGET_DIR)/usr/bin/userAppsInfo
endef
$(eval $(generic-package))


################################################################################
#
# logs
#
################################################################################

LOGS_VERSION = 1.0
LOGS_SITE = $(CURDIR)/../../../apps/logs/src
LOGS_SITE_METHOD = local
define LOGS_BUILD_CMDS
	$(MAKE) CROSS_COMPILE=$(TARGET_CROSS) -C $(@D)
endef

define LOGS_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/logs $(TARGET_DIR)/usr/bin/logs
endef
$(eval $(generic-package))


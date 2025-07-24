################################################################################
#
# userhello
#
################################################################################

USERHELLO_VERSION = 1.0
USERHELLO_SITE = /home/comdev/Desktop/workplace/projects/hamid/buildroots/bbb_br/buildroot/package/userhello/src
USERHELLO_SITE_METHOD = local
define USERHELLO_BUILD_CMDS
	$(MAKE) CROSS_COMPILE=$(TARGET_CROSS) -C $(@D)
endef

define USERHELLO_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/userhello $(TARGET_DIR)/usr/bin/userhello
endef
$(eval $(generic-package))


################################################################################
#
# libolm
#
################################################################################

LIBOLM_VERSION = 3.2.15
LIBOLM_SITE = https://gitlab.matrix.org/matrix-org/olm/-/archive/$(LIBOLM_VERSION)
LIBOLM_SOURCE = olm-$(LIBOLM_VERSION).tar.gz
LIBOLM_LICENSE = Apache-2.0
LIBOLM_LICENSE_FILES = LICENSE
LIBOLM_INSTALL_STAGING = YES

define LIBOLM_BUILD_CMDS
    $(MAKE) -C $(@D) CFLAGS="$(TARGET_CFLAGS)" CC="$(TARGET_CC)"
endef

define LIBOLM_INSTALL_TARGET_CMDS
    $(INSTALL) -D -m 0644 $(@D)/libolm.so $(TARGET_DIR)/usr/lib/libolm.so
    $(INSTALL) -D -m 0644 $(@D)/include/olm/olm.h $(TARGET_DIR)/usr/include/olm/olm.h
endef

$(eval $(generic-package))

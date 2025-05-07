#
# Copyright (C) 2025 The Android Open Source Project
# Copyright (C) 2025 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common Omni stuff.
$(call inherit-product, vendor/omni/config/common.mk)

# Inherit from beryl device
$(call inherit-product, device/xiaomi/beryl/device.mk)

PRODUCT_DEVICE := beryl
PRODUCT_NAME := omni_beryl
PRODUCT_BRAND := Redmi
PRODUCT_MODEL := beryl
PRODUCT_MANUFACTURER := xiaomi

PRODUCT_GMS_CLIENTID_BASE := android-xiaomi

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRIVATE_BUILD_DESC="beryl-user 12 SP1A.210812.016 OS2.0.3.0.VOQINXM release-keys"

BUILD_FINGERPRINT := Redmi/beryl/beryl:12/SP1A.210812.016/OS2.0.3.0.VOQINXM:user/release-keys

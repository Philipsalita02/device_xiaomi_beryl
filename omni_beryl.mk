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
PRODUCT_BRAND := POCO
PRODUCT_MODEL := POCO M7 Pro 5G
PRODUCT_MANUFACTURER := xiaomi
PRODUCT_PLATFORM := mt6855
PRODUCT_USE_DYNAMIC_PARTITIONS := true


PRODUCT_GMS_CLIENTID_BASE := android-xiaomi

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRIVATE_BUILD_DESC="beryl-user 16 BP2A.250605.031.A3 OS3.0.4.0.WOQINXM release-keys"

BUILD_FINGERPRINT := POCO/beryl_in/beryl:16/BP2A.250605.031.A3/OS3.0.4.0.WOQINXM:user/release-keys

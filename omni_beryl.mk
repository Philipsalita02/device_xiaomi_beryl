#
# Copyright (C) 2025 The Android Open Source Project
# Copyright (C) 2025 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

# 64-bit base (required for arm64 TWRP)
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)

# Telephony base (needed for SIM/MTP in recovery)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# TWRP-minimal product base
$(call inherit-product, $(SRC_TARGET_DIR)/product/base.mk)

# Device-specific configuration
$(call inherit-product, device/xiaomi/beryl/device.mk)

# ─────────────────────────────────────────────
# Product identity
# ─────────────────────────────────────────────
PRODUCT_DEVICE       := beryl
PRODUCT_NAME         := omni_beryl
PRODUCT_BRAND        := POCO
PRODUCT_MODEL        := POCO M7 Pro 5G
PRODUCT_MANUFACTURER := xiaomi
PRODUCT_PLATFORM     := mt6855

# Dynamic partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# Google client ID base (Xiaomi)
PRODUCT_GMS_CLIENTID_BASE := android-xiaomi

# ─────────────────────────────────────────────
# Build fingerprint  (HyperOS 3.0.4.0 / Android 16)
# ─────────────────────────────────────────────
PRODUCT_BUILD_PROP_OVERRIDES += \
    PRIVATE_BUILD_DESC="beryl-user 16 BP2A.250605.031.A3 OS3.0.4.0.WOQINXM release-keys"

BUILD_FINGERPRINT := POCO/beryl_in/beryl:16/BP2A.250605.031.A3/OS3.0.4.0.WOQINXM:user/release-keys

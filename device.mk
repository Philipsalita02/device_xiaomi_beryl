#
# Copyright (C) 2025 The Android Open Source Project
# Copyright (C) 2025 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

LOCAL_PATH := device/xiaomi/beryl

# ─────────────────────────────────────────────
# A/B post-install config
# ─────────────────────────────────────────────
AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=erofs \
    POSTINSTALL_OPTIONAL_system=true

# ─────────────────────────────────────────────
# Boot Control HAL (A/B slot switching)
# BUG-FIX: original device.mk had the @1.2 trio listed TWICE —
#           de-duplicated here; a single declaration is sufficient.
# ─────────────────────────────────────────────
PRODUCT_PACKAGES += \
    android.hardware.boot@1.2-impl \
    android.hardware.boot@1.2-impl.recovery \
    android.hardware.boot@1.2-service \
    bootctrl.mt6855

# APEX-based boot control (Android 13 +)
PRODUCT_PACKAGES += \
    com.android.hardware.boot \
    android.hardware.boot-service.default_recovery

# ─────────────────────────────────────────────
# OTA update stack
# ─────────────────────────────────────────────
PRODUCT_PACKAGES += \
    otapreopt_script \
    cppreopts.sh \
    update_engine \
    update_verifier \
    update_engine_sideload

# ─────────────────────────────────────────────
# Fastbootd (required for logical-partition reflash)
# ─────────────────────────────────────────────
PRODUCT_PACKAGES += \
    fastbootd

#
# for tzdata
PRODUCT_PACKAGES += \
    tzdata_twrp

# Keystore
PRODUCT_PACKAGES += \
    android.system.keystore2

# Touch firmware
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/prebuilt/touchscreen/fts_touch_i2c.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/fts_touch_i2c.ko

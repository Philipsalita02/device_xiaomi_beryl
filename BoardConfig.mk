#
# Copyright (C) 2025 The Android Open Source Project
# Copyright (C) 2025 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/xiaomi/beryl

# For building with minimal manifest
ALLOW_MISSING_DEPENDENCIES := true

# ─────────────────────────────────────────────
# Architecture
# ─────────────────────────────────────────────
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := generic
TARGET_CPU_VARIANT_RUNTIME := cortex-a55

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv7-a-neon
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := generic
TARGET_2ND_CPU_VARIANT_RUNTIME := cortex-a55

# ─────────────────────────────────────────────
# APEX
# ─────────────────────────────────────────────
OVERRIDE_TARGET_FLATTEN_APEX := true

# ─────────────────────────────────────────────
# A/B (Virtual-A/B OTA)
# ─────────────────────────────────────────────
AB_OTA_UPDATER := true
AB_OTA_PARTITIONS += \
    boot \
    init_boot \
    system \
    system_ext \
    vendor \
    product \
    vendor_dlkm \
    odm_dlkm \
    vbmeta_system \
    vbmeta_vendor
BOARD_USES_RECOVERY_AS_BOOT := false

# ─────────────────────────────────────────────
# Bootloader
# ─────────────────────────────────────────────
TARGET_BOOTLOADER_BOARD_NAME := beryl
TARGET_NO_BOOTLOADER := true

# ─────────────────────────────────────────────
# Display
# ─────────────────────────────────────────────
TARGET_SCREEN_DENSITY := 450

# ─────────────────────────────────────────────
# Kernel  (GKI / Header v4 — prebuilt)
# ─────────────────────────────────────────────
BOARD_BOOTIMG_HEADER_VERSION := 4
BOARD_KERNEL_BASE            := 0x3fff8000
BOARD_KERNEL_PAGESIZE        := 4096

# FIX #1 — Corrected ramdisk offset
# Old value 0x26f08000 produced ramdisk_addr = 0x66F00000 (wrong)
# 0x3fff8000 + 0x04008000 = 0x44000000 (correct for MT6855/beryl)
BOARD_RAMDISK_OFFSET         := 0x04008000

BOARD_KERNEL_TAGS_OFFSET     := 0x07c88000
BOARD_KERNEL_VENDOR_CMDLINE  := bootopt=64S3,32N2,64N2

BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOTIMG_HEADER_VERSION)
BOARD_MKBOOTIMG_ARGS += --ramdisk_offset $(BOARD_RAMDISK_OFFSET)
BOARD_MKBOOTIMG_ARGS += --tags_offset $(BOARD_KERNEL_TAGS_OFFSET)
BOARD_MKBOOTIMG_ARGS += --dtb $(TARGET_PREBUILT_DTB)

BOARD_KERNEL_IMAGE_NAME      := Image
BOARD_INCLUDE_DTB_IN_BOOTIMG :=
BOARD_KERNEL_SEPARATED_DTBO  := false

TARGET_PREBUILT_DTB    := $(DEVICE_PATH)/prebuilt/dtb.img
TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)/prebuilt/kernel

TARGET_FORCE_PREBUILT_KERNEL := true
TARGET_KERNEL_CONFIG         := beryl_defconfig
TARGET_KERNEL_SOURCE         := kernel/xiaomi/beryl

# ─────────────────────────────────────────────
# Partitions
# ─────────────────────────────────────────────
BOARD_FLASH_BLOCK_SIZE                := 262144
BOARD_BOOTIMAGE_PARTITION_SIZE        := 67108864
BOARD_INIT_BOOT_IMAGE_PARTITION_SIZE  := 8388608
BOARD_VENDOR_BOOTIMAGE_PARTITION_SIZE := 67108864

BOARD_HAS_LARGE_FILESYSTEM            := true
BOARD_SYSTEMIMAGE_PARTITION_TYPE      := erofs
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE    := erofs
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE  := f2fs
TARGET_COPY_OUT_VENDOR                := vendor

BOARD_SUPER_PARTITION_SIZE   := 9126805504
BOARD_SUPER_PARTITION_GROUPS := xiaomi_dynamic_partitions
BOARD_XIAOMI_DYNAMIC_PARTITIONS_PARTITION_LIST := \
    system system_ext vendor product vendor_dlkm odm_dlkm
BOARD_XIAOMI_DYNAMIC_PARTITIONS_SIZE := 9122611200

# ─────────────────────────────────────────────
# Platform
# ─────────────────────────────────────────────
TARGET_BOARD_PLATFORM := mt6855

# ─────────────────────────────────────────────
# Recovery
# ─────────────────────────────────────────────
TARGET_RECOVERY_PIXEL_FORMAT := BGRA_8888
TARGET_USERIMAGES_USE_EXT4   := true
TARGET_USERIMAGES_USE_F2FS   := true
TARGET_RECOVERY_FSTAB        := $(DEVICE_PATH)/recovery.fstab

# ─────────────────────────────────────────────
# Vendor Boot
# FIX #2 — These were described in comments but never actually set.
# Without them TWRP recovery resources never land in vendor_boot.
# ─────────────────────────────────────────────
BUILDING_VENDOR_BOOT_IMAGE                   := true
BOARD_MOVE_RECOVERY_RESOURCES_TO_VENDOR_BOOT := true

# FIX #3 — Force LZ4 frame format (no 8 MB block cap)
# LZ4 legacy hard-caps each block at 8 MB decompressed.
# TWRP ramdisk expands to ~14 MB → silent CPIO truncation → bootloop.
# LZ4 frame format has no such limit.
BOARD_RAMDISK_USE_LZ4 := true

# ─────────────────────────────────────────────
# Security / Anti-rollback
# ─────────────────────────────────────────────
VENDOR_SECURITY_PATCH   := 2099-12-31
PLATFORM_SECURITY_PATCH := 2099-12-31
PLATFORM_VERSION        := 16.1.0

# ─────────────────────────────────────────────
# Verified Boot (AVB)
# ─────────────────────────────────────────────
BOARD_AVB_ENABLE := true
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flags 3

# ─────────────────────────────────────────────
# Crypto (FBE + metadata)
# ─────────────────────────────────────────────
TW_INCLUDE_CRYPTO            := true
TW_INCLUDE_CRYPTO_FBE        := true
TW_INCLUDE_FBE_METADATA_DECRYPT := true
BOARD_USES_METADATA_PARTITION := true

# ─────────────────────────────────────────────
# TWRP Configuration
# ─────────────────────────────────────────────
TW_THEME                := portrait_hdpi
TW_EXTRA_LANGUAGES      := true
TW_INPUT_BLACKLIST      := "hbtp_vm"
TW_USE_TOOLBOX          := true
TW_INCLUDE_REPACKTOOLS  := true
TW_INCLUDE_RESETPROP    := true
TW_INCLUDE_NTFS_3G      := true
TW_INCLUDE_FUSE_EXFAT   := true
TW_INCLUDE_FUSE_NTFS    := true
RECOVERY_SDCARD_ON_DATA := true
TW_HAS_MTP              := true
TW_MTP_DEVICE           := /dev/mtp_usb

TW_BRIGHTNESS_PATH    := "/sys/class/leds/lcd-backlight/brightness"
TW_MAX_BRIGHTNESS     := 2047
TW_DEFAULT_BRIGHTNESS := 1200

TW_DEVICE_VERSION             := 2
TW_BACKUP_EXCLUSIONS          := /data/fonts
TW_EXCLUDE_DEFAULT_USB_INIT   := true
TW_FASTBOOT_MODE              := true
TW_SUPPORT_INPUT_AIDL_HAPTICS := true

# FIX #4 — Removed TW_SCREEN_BLANK_ON_BOOT (was contradicting TW_NO_SCREEN_BLANK)
TW_NO_SCREEN_BLANK := true

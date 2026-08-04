#
# Copyright (C) 2025 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base.mk)

# Inherit some common Lineage stuff.
$(call inherit-product, vendor/lineage/config/common_full_tablet_wifionly.mk)

# Inherit from r0q device
$(call inherit-product, device/samsung/r0q/device.mk)

PRODUCT_DEVICE := r0q
PRODUCT_NAME := lineage_r0q
PRODUCT_MODEL := SM-S901E
PRODUCT_MANUFACTURER := samsung
PRODUCT_BRAND := samsung

PRODUCT_GMS_CLIENTID_BASE := android-samsung
BUILD_FINGERPRINT := samsung/r0qxxx/r0q:12/SP1A.210812.016/S901EXXSCFYI2:user/release-keys

PRODUCT_BUILD_PROP_OVERRIDES += \
    BuildDesc="r0qxxx-user 15 AP3A.240905.015.A2 S901EXXSCFYI2 release-keys" \
    BuildFingerprint=samsung/r0qxxx/r0q:15/AP3A.240905.015.A2/S901EXXSCFYI2:user/release-keys \
    DeviceProduct=r0q \
    SystemName=r0q

#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit from r0q device
$(call inherit-product, device/samsung/r0q/device.mk)

# Inherit some common Lineage stuff.
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

PRODUCT_DEVICE := r0q
PRODUCT_NAME := lineage_r0q
PRODUCT_BRAND := samsung
PRODUCT_MODEL := SM-S901E
PRODUCT_MANUFACTURER := samsung

PRODUCT_GMS_CLIENTID_BASE := android-samsung-ss

PRODUCT_BUILD_PROP_OVERRIDES += \
    BuildDesc="r0qxxx-user 16 BP2A.250605.031.A3 S901EXXSCGZA2 release-keys" \
    BuildFingerprint=samsung/r0qxxx/qssi:16/BP2A.250605.031.A3/S901EXXSCGZA2:user/release-keys
PRODUCT_SOONG_NAMESPACES += hardware/qcom-caf/wlan

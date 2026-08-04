#! /vendor/bin/sh
# loggy.sh.

DATE=$(date +%F_%H-%M-%S)

if [ "$1" = "early" ]; then
    # 第一階段：只能用 dmesg（因為 logd/logcat 還沒啟）
    dmesg -w > /cache/kmsg_${DATE}.txt &
else
    # 第二階段：logd 已啟動，可以抓完整 logcat
    logcat -b all -v time -f /cache/logcat_${DATE}.txt &
fi
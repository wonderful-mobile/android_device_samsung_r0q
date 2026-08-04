#! /vendor/bin/sh

if [ "$#" -ne 1 ]
then
    echo "Usage: $0 <hdm_status value>"
    exit
fi

count=0
policy=0
array=(1 2 4 8 16 32 64 128 256 512)
name_arry=(cam mmc usb wlan bt gps dis aud cpm sen)


hdm_status=$1
hdm_swblock_status=$(getprop "ro.vendor.hdm.supported.swblock")

echo "hdmstatus = $hdm_status"
echo "hdm supported swblock = $hdm_swblock_status"

HDM_STATUS_SPLIT=$(echo $hdm_status | tr "&|" "\n")

#get hdm policy from ro.boot.hdm_status
for split in $HDM_STATUS_SPLIT
do
    count=$((($count + 1)%2))
    if [ $count -eq 0 ]; then
        split16="0x$split"
        echo "split16 = $split16"
        policy=$(($policy|$split16))
    fi
done

echo "$policy"
hex=$(printf "0x%x" "$policy")
echo "$hex"

#setprop vendor.hdm.status "$hex"

#check sw block
swblock=$(($policy&$hdm_swblock_status))
swblockhex=$(printf "0x%x" "$swblock")
echo "swblockhex = $swblockhex"

setprop vendor.hdm.swblock.status "$swblockhex"

#start sw block
count=0
for isblock in ${array[@]}
do
    if [ $(($isblock&$swblock)) -eq $isblock ]; then
        echo "swblock enable = ${name_arry[$count]}"
        swblockname=$(printf "vendor.hdm.internal.%s" "${name_arry[$count]}")
        setprop $swblockname "boot"
    fi
    count=$(($count + 1))
done

################### export hdm, pad supported subsystem ################### 
sysfs="/sys/devices/virtual/sec/hdm/"
sysfs_hdm_name="hdm_subsystem"
sysfs_pad_name="pad_subsystem"
sysfs_hdm_block_type="bt_block_sub"
sysfs_hdm_unblock_type="bt_unblock_sub"

hdm_subsystem=$(cat $sysfs$sysfs_hdm_name)
pad_subsystem=$(cat $sysfs$sysfs_pad_name)
hdm_block_type=$(cat $sysfs$sysfs_hdm_block_type)
hdm_unblock_type=$(cat $sysfs$sysfs_hdm_unblock_type)

if [[ "${hdm_subsystem:0:2}" == "0x" ]]; then
echo "hdm_subsystem = $hdm_subsystem"
setprop ro.vendor.hdm.hdm_supported_subsystem "${hdm_subsystem:2}"

echo "pad_subsystem = $pad_subsystem"
setprop ro.vendor.hdm.pad_supported_subsystem "${pad_subsystem:2}"
fi

if [[ "${hdm_block_type:0:2}" == "0x" ]]; then
echo "hdm_block_type = $hdm_block_type"
setprop ro.vendor.hdm.btonly.subsystem "${hdm_block_type:2}"

echo "hdm_unblock_type = $hdm_unblock_type"
setprop ro.vendor.hdm.btonly.unblock.subsystem "${hdm_unblock_type:2}"
fi
################### export hdm, pad supported subsystem ################### 



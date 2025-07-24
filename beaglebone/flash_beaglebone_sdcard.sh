#!/bin/bash

# SD card device path (e.g., /dev/sdX)
SDCARD="/dev/sdX"
IMAGES_DIR="/home/comdev/Desktop/workplace/projects/hamid/buildroots/beaglebone/buildroot/output/images"

# Prompt user to confirm the SD card device
read -p "⚠️  Please confirm the SD card device path (e.g., /dev/sdX): " SDCARD
echo "You entered: $SDCARD"
read -p "Are you sure you want to format and write to $SDCARD? This will erase all data! (yes/[no]): " CONFIRM

if [[ "$CONFIRM" != "yes" ]]; then
    echo "Aborted."
    exit 1
fi

# Unmount any mounted partitions
echo "Unmounting existing partitions..."
sudo umount ${SDCARD}?* 2>/dev/null

# Partition the SD card
echo "Partitioning $SDCARD..."
sudo parted -s $SDCARD mklabel msdos
sudo parted -s $SDCARD mkpart primary fat32 1MiB 100MiB
sudo parted -s $SDCARD mkpart primary ext4 100MiB 100%

# Wait for the kernel to recognize the new partitions
sleep 2

# Format the partitions
echo "Formatting boot partition..."
sudo mkfs.vfat -F 32 ${SDCARD}1 -n BOOT

echo "Formatting rootfs partition..."
sudo mkfs.ext4 ${SDCARD}2 -L rootfs

# Create mount points
mkdir -p /tmp/sdboot /tmp/sdroot

# Mount partitions
echo "Mounting partitions..."
sudo mount ${SDCARD}1 /tmp/sdboot
sudo mount ${SDCARD}2 /tmp/sdroot

# Copy bootloader and kernel
echo "Copying bootloader and kernel..."
sudo cp ${IMAGES_DIR}/MLO /tmp/sdboot/
sudo cp ${IMAGES_DIR}/u-boot.img /tmp/sdboot/
sudo cp ${IMAGES_DIR}/zImage /tmp/sdboot/
sudo cp ${IMAGES_DIR}/am335x-boneblack.dtb /tmp/sdboot/

# Extract root filesystem
echo "Extracting root filesystem..."
sudo tar -xpf ${IMAGES_DIR}/rootfs.tar -C /tmp/sdroot

# Sync and unmount
echo "Syncing and unmounting..."
sync
sudo umount /tmp/sdboot
sudo umount /tmp/sdroot

echo "✅ SD card is ready for BeagleBone Black boot."

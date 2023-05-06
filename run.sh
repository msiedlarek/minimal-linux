#!/bin/sh

set -ex

. "$(dirname $0)/config.sh"

TARGET_ARCH=$1
INSTALL_DIR="${TARGET_DIR}/${TARGET_ARCH}"

IMAGE_PATH="${BUILD_DIR}/${TARGET_ARCH}/image.qcow2"

if [ ! -e "${INSTALL_DIR}/boot/vmlinuz" ]; then
    printf "Target not built: %s\n" "$INSTALL_DIR" >&2
    exit 1
fi

mkdir -p $(dirname "$IMAGE_PATH")
virt-make-fs --format=qcow2 --partition=gpt --type=ext4 --size=+20M "$INSTALL_DIR" "$IMAGE_PATH"
if [ "$TARGET_ARCH" = "arm64" ]; then
	qemu-system-aarch64 \
		-machine virt \
		-cpu cortex-a57 \
		-nographic \
		-smp 4 \
		-m 4G \
		-hda "${IMAGE_PATH}" \
		-kernel "${INSTALL_DIR}/boot/vmlinuz" \
		-append "console=ttyAMA0 root=/dev/vda1 rw init=/sbin/init"
else
	qemu-system-x86_64 \
		-enable-kvm \
		-serial mon:stdio \
		-nographic \
		-smp 4 \
		-m 4G \
		-hda "${IMAGE_PATH}" \
		-kernel "${INSTALL_DIR}/boot/vmlinuz-"* \
		-append "console=ttyS0 root=/dev/sda1 rw init=/sbin/init"
fi

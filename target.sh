#!/bin/sh

set -ex

. "$(dirname $0)/config.sh"

TARGET_ARCH=$1
if [ "$TARGET_ARCH" = "arm64" ]; then
    TARGET_TRIPLE=aarch64-unknown-linux-musl
elif [ "$TARGET_ARCH" = "x86_64" ]; then
    TARGET_TRIPLE=x86_64-unknown-linux-musl
else
	printf "Usage: $0 [arm64|x86_64]\n" >&2
	exit 1
fi

BUILD_DIR="${BUILD_DIR}/${TARGET_ARCH}"
INSTALL_DIR="${TARGET_DIR}/${TARGET_ARCH}"

if [ ! -e "${INSTALL_DIR}/boot/vmlinuz" ]; then
	mkdir -p "${BUILD_DIR}/linux"
	if [ "$TARGET_ARCH" = "arm64" ]; then
		(
			cd "${SRC_DIR}/linux" \
			&& env ARCH="${TARGET_ARCH}" ./scripts/kconfig/merge_config.sh \
				-O "${BUILD_DIR}/linux" \
				arch/${TARGET_ARCH}/configs/defconfig \
				arch/${TARGET_ARCH}/configs/virt.config
		)
	else
		make -C "${SRC_DIR}/linux" \
			ARCH="${TARGET_ARCH}" \
			O="${BUILD_DIR}/linux" \
			defconfig
	fi
	mkdir -p "${INSTALL_DIR}/boot"
	make -C "${BUILD_DIR}/linux" -j$(($(nproc) > 2 ? $(nproc) - 2 : 1)) \
		ARCH="${TARGET_ARCH}" \
		LLVM="${TOOLCHAIN_DIR}" \
		CC="ccache ${TOOLCHAIN_DIR}/bin/clang" \
		O="${BUILD_DIR}/linux" \
		INSTALL_PATH="${INSTALL_DIR}/boot" \
		INSTALL_MOD_PATH="${INSTALL_DIR}" \
		INSTALL_HDR_PATH="${INSTALL_DIR}" \
		KBUILD_BUILD_USER=build \
		KBUILD_BUILD_HOST=builder \
		olddefconfig all install modules_install headers_install
	(cd "${INSTALL_DIR}/boot" && ln -s vmlinuz-* vmlinuz)
fi

if [ ! -f "${INSTALL_DIR}/lib/libc.a" ]; then
	mkdir -p "${BUILD_DIR}/musl"
	(cd "${BUILD_DIR}/musl" && env \
		CC="${TOOLCHAIN_DIR}/bin/clang" \
		CFLAGS="--target=${TARGET_TRIPLE} -flto=thin -fPIC -O3" \
		AR="${TOOLCHAIN_DIR}/bin/llvm-ar" \
		RANLIB="${TOOLCHAIN_DIR}/bin/llvm-ranlib" \
		LIBCC="$(${TOOLCHAIN_DIR}/bin/clang --target=${TARGET_TRIPLE} -print-libgcc-file-name)" \
		"${SRC_DIR}/musl/configure" \
		--target="${TARGET_TRIPLE}" \
		--prefix=/ \
		--syslibdir=/lib \
		--disable-shared \
		--enable-static \
		--enable-wrapper=no
	)
	make -j -C "${BUILD_DIR}/musl" DESTDIR="${INSTALL_DIR}" install
fi

if [ ! -f "${INSTALL_DIR}/lib/libc++.a" ]; then
	cmake \
		-DTOOLCHAIN_DIR="${TOOLCHAIN_DIR}" \
		-DTARGET_TRIPLE="${TARGET_TRIPLE}" \
		-DCMAKE_SYSROOT="${INSTALL_DIR}" \
		-DCMAKE_INSTALL_PREFIX="${INSTALL_DIR}" \
		-DCMAKE_CXX_COMPILER_LAUNCHER=ccache \
		-C "${PROJECT_DIR}/llvm/libcxx.cmake" \
		-S "${SRC_DIR}/llvm/runtimes" \
		-B "${BUILD_DIR}/llvm-libcxx"
	make -j -C "${BUILD_DIR}/llvm-libcxx" install
fi

if [ ! -f "${INSTALL_DIR}/bin/clang" ]; then
	cmake \
		-DTOOLCHAIN_DIR="${TOOLCHAIN_DIR}" \
		-DTARGET_TRIPLE="${TARGET_TRIPLE}" \
		-DLLVM_TARGETS_TO_BUILD="${LLVM_TARGETS}" \
		-DCMAKE_SYSROOT="${INSTALL_DIR}" \
		-DCMAKE_INSTALL_PREFIX="${INSTALL_DIR}" \
		-DCMAKE_CXX_COMPILER_LAUNCHER=ccache \
		-C "${PROJECT_DIR}/llvm/clang.cmake" \
		-S "${SRC_DIR}/llvm/llvm" \
		-B "${BUILD_DIR}/llvm-clang"
	make -j -C "${BUILD_DIR}/llvm-clang" install-distribution
fi

if [ ! -f "${INSTALL_DIR}/bin/busybox" ]; then
	mkdir -p "${BUILD_DIR}/busybox"
	make -C "${SRC_DIR}/busybox" \
		HOSTCC="${TOOLCHAIN_DIR}/bin/clang" \
		O="${BUILD_DIR}/busybox" \
		defconfig
	sed -i'' -E 's/^#? *(CONFIG_STATIC|CONFIG_PIE|CONFIG_FDISK_SUPPORT_LARGE_DISKS|CONFIG_INSTALL_NO_USR)[= ].*$/\1=y/' "${BUILD_DIR}/busybox/.config"
	sed -i'' -E 's/^#? *(CONFIG_LINUXRC)[= ].*$/\1=n/' "${BUILD_DIR}/busybox/.config"
	make -C "${BUILD_DIR}/busybox" oldconfig
	make -C "${BUILD_DIR}/busybox" -j \
		CROSS_COMPILE="${TOOLCHAIN_DIR}/bin/llvm-" \
		HOSTCC="${TOOLCHAIN_DIR}/bin/clang" \
		CC="${TOOLCHAIN_DIR}/bin/clang" \
		CFLAGS="--target=${TARGET_TRIPLE} --sysroot=${INSTALL_DIR} -flto=thin -O3" \
		LDFLAGS="--target=${TARGET_TRIPLE} --sysroot=${INSTALL_DIR} -flto=thin" \
		AR="${TOOLCHAIN_DIR}/bin/llvm-ar" \
		CONFIG_PREFIX="${INSTALL_DIR}" \
		install
	sudo chown 0:0 "${INSTALL_DIR}/bin/busybox"
	sudo chmod 4755 "${INSTALL_DIR}/bin/busybox"
fi

mkdir -p "${INSTALL_DIR}/etc/init.d"
cat > "${INSTALL_DIR}/etc/inittab" <<"EOF"
::sysinit:/etc/init.d/rcS
::shutdown:/sbin/swapoff -a
::shutdown:/bin/umount -a -r
::restart:/sbin/init
::askfirst:-/bin/sh
EOF
cat > "${INSTALL_DIR}/etc/init.d/rcS" <<"EOF"
#!/bin/sh
mkdir -p /proc /sys /dev /tmp
mount -t proc proc /proc
mount -t sysfs sysfs /sys
mount -t devtmpfs none /dev
EOF
chmod 0755 "${INSTALL_DIR}/etc/init.d/rcS"

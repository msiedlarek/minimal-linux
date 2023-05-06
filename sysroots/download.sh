#!/bin/sh

set -ex

SYSROOTS_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)

for arch in x86_64 aarch64; do
    sysroot_dir="${SYSROOTS_DIR}/${arch}"
    if [ ! -f "${sysroot_dir}/lib/libc.a" ]; then
        mkdir -p "${sysroot_dir}"
        curl --location --fail "https://dl-cdn.alpinelinux.org/alpine/v3.18/main/${arch}/linux-headers-6.3-r0.apk" \
            | tar -C "${sysroot_dir}" --strip-components=1 -xzf -
        curl --location --fail "https://dl-cdn.alpinelinux.org/alpine/v3.18/main/${arch}/musl-dev-1.2.4-r0.apk" \
            | tar -C "${sysroot_dir}" --strip-components=1 -xzf -
    fi
done

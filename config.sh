#!/bin/sh

set -e

PROJECT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
SRC_DIR="${PROJECT_DIR}/src"
BUILD_DIR="${PROJECT_DIR}/build"
SYSROOTS_DIR="${PROJECT_DIR}/sysroots"
TOOLCHAIN_DIR="${PROJECT_DIR}/toolchain"
TARGET_DIR="${PROJECT_DIR}/target"

LLVM_TARGETS="X86;ARM;AArch64"
LLVM_TRIPLES="x86_64-unknown-linux-musl;aarch64-unknown-linux-musl"

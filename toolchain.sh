#!/bin/sh

set -ex

. "$(dirname $0)/config.sh"

if [ ! -f "${TOOLCHAIN_DIR}/bin/clang" ]; then
    cmake \
        -DSYSROOTS_DIR="${SYSROOTS_DIR}" \
        -DLLVM_TARGETS="${LLVM_TARGETS}" \
        -DLLVM_TRIPLES="${LLVM_TRIPLES}" \
        -DCMAKE_INSTALL_PREFIX="${TOOLCHAIN_DIR}" \
        -DCMAKE_CXX_COMPILER_LAUNCHER=ccache \
        -C "${PROJECT_DIR}/llvm/toolchain.cmake" \
        -S "${SRC_DIR}/llvm/llvm" \
        -B "${BUILD_DIR}/llvm-toolchain"
    make -j -C "${BUILD_DIR}/llvm-toolchain" install-distribution
fi

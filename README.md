# Minimal Linux

This is a proof-of-concept of an extremely minimalistic Linux distribution,
built directly from upstream source. The distribution consists only of:

* [Linux](https://kernel.org/) kernel
* [musl](https://musl.libc.org/) libc
* [busybox](https://busybox.net/) init and userland utilities
* [LLVM](https://llvm.org/) compiler infrastructure, including clang, libc++ and binutils

In theory, this is just enough to have a working shell, a text editor and a
compiler. You can write everything else you need yourself. :)

The distribution is cross-compiled by default and currently x86_64 and ARM64
targets are supported. Everything is statically linked for simplicity. All
sources are copied into this repository from upstream, without any
modifications or patches.

## Building

There is no real build and packaging system. The entire build process is
wrapped in a very simple, linear shell script. It is intended to be easy to
understand and strip the entire process of any magic. You could
theoretically just copy and paste each commands into your shell.

### Dependencies

* A C/C++ compiler toolchain (GCC or Clang)
* [ccache](https://ccache.dev/) to make recompilation faster for huge Linux
and LLVM codebases
* [QEMU](https://www.qemu.org/) and
[libguestfs tools](https://www.libguestfs.org/) to run the built distribution
in a virtual machine

### Toolchain

First, we build the cross-compilation toolchain based on LLVM:

```shell
./toolchain.sh
```

This installs the toolchain in `./toolchain`, including clang, binutils and
libc++ statically linked against musl. This toolchain is capable of producing
binaries for all supported platforms (x86_64 and ARM64) and the host system.

### Target

Next, we use the toolchain to build the actual target system. This is done with
a simple script, taking the target architecture as its only argument.

```shell
./target.sh x86_64
./target.sh arm64
```

After the build, the complete target sysroot can be found in
`./target/<architecture>`. It can be used directly as a chroot environment, or
serve as an actuall root filesystem booted into by a real machine.

### Testing

Included script allows you to build a disk from the previously built systroot
and run it using [QEMU](https://www.qemu.org/).

```shell
./run.sh x86_64
./run.sh arm64
```

## Related projects and inspiration

* [oasis](https://github.com/oasislinux/oasis.git)
* [Linux from Scratch](https://www.linuxfromscratch.org/)
* [stali](https://sta.li/)

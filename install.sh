#!/bin/bash

# Download stuff needed for osdev compiler
echo 'Creating directories for osdev and downloading stuff'
mkdir $HOME/osdev
cd $HOME/osdev
wget https://sunsite.icm.edu.pl/pub/gnu/binutils/binutils-2.31.1.tar.gz
wget https://ftp.gnu.org/gnu/gcc/gcc-8.2.0/gcc-8.2.0.tar.gz
apt-get install -y make nasm gcc g++ xorriso curl
apt-get install -y libgmp-dev libmpfr-dev libmpc-dev
apt-get install -y grub-common
tar -xzf binutils-2.31.1.tar.gz
tar -xzf gcc-8.2.0.tar.gz
echo 'Preparing to compile toolchain'
mkdir build-binutils
mkdir build-gcc
mkdir $HOME/opt
mkdir $HOME/opt/cross
export PREFIX="$HOME/opt/cross"
export TARGET=i686-elf
export PATH="$PREFIX/bin:$PATH"
cd build-binutils
../binutils-2.31.1/configure --target=$TARGET --prefix="$PREFIX" --with-sysroot --disable-nls --disable-werror
make -j5
make install
cd $HOME/osdev/build-gcc
../gcc-8.2.0/configure --target=$TARGET --prefix="$PREFIX" --disable-nls --enable-languages=c,c++ --without-headers
make all-gcc -j5
make all-target-libgcc -j5
make install-gcc
make install-target-libgcc
rm -rf $HOME/osdev
echo 'Done!'


#!/bin/sh

export MACOSX_DEPLOYMENT_TARGET=10.7
export CC=/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/clang
export CXX=/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/clang++
export CPPFLAGS="-I/usr/local/opt/openssl/include -I/usr/local/opt/xz/include"
export CFLAGS="-stdlib=libc++"
export CXXFLAGS="-stdlib=libc++"
export LDFLAGS="-L/usr/local/opt/openssl/lib -L/usr/local/opt/xz/lib"
export PKG_CONFIG_PATH="/usr/local/opt/xz/lib/pkgconfig:$PKG_CONFIG_PATH"
export PKG_CONFIG_PATH="/usr/local/opt/openssl/lib/pkgconfig:$PKG_CONFIG_PATH"

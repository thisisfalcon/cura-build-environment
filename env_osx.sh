#!/bin/sh

export MACOSX_DEPLOYMENT_TARGET=10.7
export CC=/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/clang
export CXX=/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/clang++

export CXXFLAGS="-stdlib=libc++"

# openssl
export CPATH="/usr/local/opt/openssl/include:$CPATH"
export LIBRARY_PATH="/usr/local/opt/openssl/lib:$LIBRARY_PATH"
export PKG_CONFIG_PATH="/usr/local/opt/openssl/lib/pkgconfig:$PKG_CONFIG_PATH"

# openblas
export CPATH="/usr/local/opt/openblas/include:$CPATH"
export LIBRARY_PATH="/usr/local/opt/openblas/lib:$LIBRARY_PATH"
export PKG_CONFIG_PATH="/usr/local/opt/openblas/lib/pkgconfig:$PKG_CONFIG_PATH"

# sqlite
export CPATH="/usr/local/opt/sqlite/include:$CPATH"
export LIBRARY_PATH="/usr/local/opt/sqlite/lib:$LIBRARY_PATH"
export PKG_CONFIG_PATH="/usr/local/opt/sqlite/lib/pkgconfig:$PKG_CONFIG_PATH"

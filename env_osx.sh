#!/bin/sh

export MACOSX_DEPLOYMENT_TARGET=10.7
export CMAKE_OSX_DEPLOYMENT_TARGET=10.7
export CMAKE_CXX_FLAGS="-stdlib=libc++"
export CC=/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/clang
export CXX=/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/clang++
export CPATH="/usr/local/opt/openssl/include:/usr/local/opt/sqlite/include:$CPATH"
export LIBRARY_PATH="/usr/local/opt/openssl/lib:/usr/local/opt/sqlite/lib:$LIBRARY_PATH"
export PKG_CONFIG_PATH="/usr/local/opt/openssl/lib/pkgconfig:/usr/local/opt/sqlite/lib/pkgconfig:$PKG_CONFIG_PATH"
export CXXFLAGS="-stdlib=libc++"

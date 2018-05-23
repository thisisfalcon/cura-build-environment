set(python_patch_command "")
set(python_configure_command ./configure --prefix=${CMAKE_INSTALL_PREFIX} --enable-shared --enable-optimizations --enable-ipv6 --with-threads --without-pymalloc)
set(python_build_command make)
set(python_install_command make install)

if(BUILD_OS_OSX)
    # See http://bugs.python.org/issue21381
    # The interpreter crashes when MACOSX_DEPLOYMENT_TARGET=10.7 due to the increased stack size.
    set(python_patch_command sed -i".bak" "9467,9467d" <SOURCE_DIR>/configure)
    # Since OS X 10.11, System Integrity Protection (SIP) is introduced to enhance security. It clears
    # DYLD_LIBRARY_PATH for all sub-processes so now setting DYLD_LIBRARY_PATH won't work. We now compile
    # Python by linking to the OS X framework to avoid this problem.
    set(python_configure_command ./configure --prefix=${CMAKE_INSTALL_PREFIX} --enable-framework --disable-shared --enable-optimizations --enable-ipv6 --with-threads --without-pymalloc)
    # OS X 10.11 removed OpenSSL. Brew now refuses to link so we need to manually tell Python's build system
    # to use the right linker flags.
    set(python_configure_command CPPFLAGS=-I/usr/local/opt/openssl/include LDFLAGS=-L/usr/local/opt/openssl/lib PKG_CONFIG_PATH=/usr/local/opt/openssl/lib/pkgconfig ${python_configure_command})
endif()

if(BUILD_OS_LINUX)
    # Set a proper RPATH so everything depending on Python does not need LD_LIBRARY_PATH
    set(python_configure_command LDFLAGS=-Wl,-rpath=${CMAKE_INSTALL_PREFIX}/lib ${python_configure_command})
endif()

if(BUILD_OS_WINDOWS)
    # Otherwise Python will not be able to get external dependencies.
    find_package(Subversion REQUIRED)
    
    set(python_configure_command )

    if(BUILD_OS_WIN32)
        set(python_build_command cmd /c "<SOURCE_DIR>/PCbuild/build.bat --no-tkinter -c Release -e -M -p Win32")
        set(python_install_command cmd /c "${CMAKE_SOURCE_DIR}/projects/install_python_windows.bat win32 <SOURCE_DIR> ${CMAKE_INSTALL_PREFIX}")
    else()
    set(python_build_command cmd /c "<SOURCE_DIR>/PCbuild/build.bat --no-tkinter -c Release -e -M -p x64")
        set(python_install_command cmd /c "${CMAKE_SOURCE_DIR}/projects/install_python_windows.bat amd64 <SOURCE_DIR> ${CMAKE_INSTALL_PREFIX}")
    endif()
endif()

ExternalProject_Add(Python
    URL https://www.python.org/ftp/python/3.6.6/Python-3.6.6.tgz
    URL_MD5 9a080a86e1a8d85e45eee4b1cd0a18a2
    PATCH_COMMAND ${python_patch_command}
    CONFIGURE_COMMAND "${python_configure_command}"
    BUILD_COMMAND ${python_build_command}
    INSTALL_COMMAND ${python_install_command}
    BUILD_IN_SOURCE 1
)

# Make sure pip and setuptools are installed into our new Python
ExternalProject_Add_Step(Python ensurepip
    COMMAND ${PYTHON_EXECUTABLE} -m ensurepip
    DEPENDEES install
)

ExternalProject_Add_Step(Python upgrade_packages
    COMMAND ${PYTHON_EXECUTABLE} -m pip install pip==18.0
    COMMAND ${PYTHON_EXECUTABLE} -m pip install setuptools==40.0.0
    COMMAND ${PYTHON_EXECUTABLE} -m pip install pytest==3.7.1
    COMMAND ${PYTHON_EXECUTABLE} -m pip install pytest-cov==2.5.1
    DEPENDEES ensurepip
)

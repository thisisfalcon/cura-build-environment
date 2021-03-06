if(NOT BUILD_OS_WINDOWS)
    set(geos_configure_args
        -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}
        -DCMAKE_PREFIX_PATH=${CMAKE_PREFIX_PATH}
        -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
    )

    if(BUILD_OS_OSX)
        if(CMAKE_OSX_DEPLOYMENT_TARGET)
            list(APPEND geos_configure_args
                -DCMAKE_OSX_DEPLOYMENT_TARGET=${CMAKE_OSX_DEPLOYMENT_TARGET}
            )
        endif()
        if(CMAKE_OSX_SYSROOT)
            list(APPEND geos_configure_args
                -DCMAKE_OSX_SYSROOT=${CMAKE_OSX_SYSROOT}
            )
        endif()
    endif()

    ExternalProject_Add(Geos
        URL https://github.com/libgeos/geos/archive/3.6.2.tar.gz
        URL_HASH SHA256=e9ac89baab59dbb585c38f8b8449627d53b57ae79100d8bbca836907c0b6c27a
        CONFIGURE_COMMAND ${CMAKE_COMMAND} ${geos_configure_args} -G ${CMAKE_GENERATOR} ../Geos
    )
endif()

if(BUILD_OS_LINUX)
    ExternalProject_Add(glib
        GIT_REPOSITORY https://github.com/GNOME/glib.git
        GIT_TAG 2.57.1
        CONFIGURE_COMMAND ${CMAKE_CURRENT_BINARY_DIR}/glib-prefix/src/glib/autogen.sh --prefix=${CMAKE_INSTALL_PREFIX}
        BUILD_COMMAND ${MAKE}
    )
else()
    add_custom_target(glib)
endif()

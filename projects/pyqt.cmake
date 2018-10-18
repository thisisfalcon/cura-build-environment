if (QT_VERSION STREQUAL "5.8")
    set (pyqt_version 5.8.2)
    set (pyqt_targz_md5 c3048e9d242f3e72fd393630da1d971a)
elseif (QT_VERSION STREQUAL "5.9")
    set (pyqt_version 5.9.2)
    set (pyqt_targz_md5 33d6d2ab8183da17ac18b8132a4b278e)
elseif (QT_VERSION STREQUAL "5.10")
    set (pyqt_version 5.10)
    set (pyqt_targz_md5 4874c5985246fdeb4c3c7843a3e6ef53)
endif ()
set (pyqt_url https://downloads.sourceforge.net/project/pyqt/PyQt5/PyQt-${pyqt_version}/PyQt5_gpl-${pyqt_version}.tar.gz)

set(pyqt_command "")
if(BUILD_OS_WINDOWS)

    add_custom_target(PyQt
        COMMAND ${PYTHON_EXECUTABLE} -m pip install PyQt5==${pyqt_version}
        COMMENT "Installing PyQt5"
    )

    SetProjectDependencies(TARGET PyQt DEPENDS Python)
else()
    if(BUILD_OS_OSX)
        set(pyqt_command
            "DYLD_LIBRARY_PATH=${CMAKE_INSTALL_PREFIX}/lib"
            ${PYTHON_EXECUTABLE} configure.py
            --sysroot ${CMAKE_INSTALL_PREFIX}
            --qmake ${CMAKE_INSTALL_PREFIX}/bin/qmake
            --sip ${CMAKE_INSTALL_PREFIX}/bin/sip
            --confirm-license
        )
    else()
        set(pyqt_command
            # On Linux, PyQt configure fails because it creates an executable that does not respect RPATH
            "LD_LIBRARY_PATH=${CMAKE_INSTALL_PREFIX}/lib"
            ${PYTHON_EXECUTABLE} configure.py
            --sysroot ${CMAKE_INSTALL_PREFIX}
            --qmake ${CMAKE_INSTALL_PREFIX}/bin/qmake
            --sip ${CMAKE_INSTALL_PREFIX}/bin/sip
            --confirm-license
        )
    endif()

    ExternalProject_Add(PyQt
        URL ${pyqt_url}
        URL_MD5 ${pyqt_targz_md5}
        CONFIGURE_COMMAND ${pyqt_command}
        BUILD_IN_SOURCE 1
    )

    SetProjectDependencies(TARGET PyQt DEPENDS Qt Sip)

endif()

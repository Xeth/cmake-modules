
if (LIBNOTIFY_INCLUDE_DIR AND LIBNOTIFY_LIBRARIES)
    set(LibNotify_FIND_QUIETLY TRUE)
else()
    find_package(PkgConfig)
    pkg_check_modules(LIBNOTIFY QUIET libnotify)

    find_path(LIBNOTIFY_INCLUDE_DIR
        NAMES notify.h
        HINTS ${LIBNOTIFY_INCLUDEDIR}
          ${LIBNOTIFY_INCLUDE_DIRS}
        PATH_SUFFIXES libnotify
    )

    find_library(LIBNOTIFY_LIBRARIES
        NAMES notify
        HINTS ${LIBNOTIFY_LIBDIR}
          ${LIBNOTIFY_LIBRARY_DIRS}
    )

endif()

include(FindPackageHandleStandardArgs)
FIND_PACKAGE_HANDLE_STANDARD_ARGS(LibNotify DEFAULT_MSG LIBNOTIFY_INCLUDE_DIR LIBNOTIFY_LIBRARIES)

mark_as_advanced(
    LIBNOTIFY_INCLUDE_DIR
    LIBNOTIFY_LIBRARIES
)

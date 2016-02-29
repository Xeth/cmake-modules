include(FindPackageHandleStandardArgs)

if (JSONCPP_INCLUDE_DIR AND JSONCPP_LIBRARY)
    set(JsonCPP_FIND_QUIETLY TRUE)
else  (JSONCPP_INCLUDE_DIR AND JSONCPP_LIBRARY)

    set(JsonCPP_FIND_QUIETLY FALSE)

    if (WIN32)
        find_path (JSONCPP_ROOT_DIR
          HINTS $ENV{PROGRAMFILES}/jsoncpp
          NAMES include/json/value.h
          #PATH_SUFFIXES jsoncpp
          DOC "jsoncpp root directory")
    else ()
        find_path (JSONCPP_ROOT_DIR
          NAMES jsoncpp/json/value.h
          PATHS ENV JSONCPPROOT
          DOC "jsoncpp root directory")
    endif()

    find_path (JSONCPP_INCLUDE_DIR
      NAMES json/value.h
      HINTS ${JSONCPP_ROOT_DIR} ${JSONCPP_ROOT_DIR}/include
      PATH_SUFFIXES jsoncpp
      DOC "jsoncpp include directory")

    find_library(
        JSONCPP_LIBRARY
        NAMES jsoncpp
        HINTS ${JSONCPP_ROOT_DIR} ${JSONCPP_ROOT_DIR}/lib
    )

endif (JSONCPP_INCLUDE_DIR AND JSONCPP_LIBRARY)


FIND_PACKAGE_HANDLE_STANDARD_ARGS(JsonCPP DEFAULT_MSG JSONCPP_INCLUDE_DIR JSONCPP_LIBRARY)
mark_as_advanced(JSONCPP_INCLUDE_DIR JSONCPP_LIBRARY)

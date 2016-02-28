include(FindPackageHandleStandardArgs)

if (JSONCPP_INCLUDE_DIR AND JSONCPP_LIBRARY)
    set(JsonCPP_FIND_QUIETLY TRUE)
else  (JSONCPP_INCLUDE_DIR AND JSONCPP_LIBRARY)

    set(JsonCPP_FIND_QUIETLY FALSE)

    find_path (JSONCPP_ROOT_DIR
      NAMES jsoncpp/json/value.h
      PATHS ENV JSONCPPROOT
      DOC "jsoncpp root directory")

    find_path (JSONCPP_INCLUDE_DIR
      NAMES json/value.h
      HINTS ${JSONCPP_ROOT_DIR}
      PATH_SUFFIXES jsoncpp
      DOC "jsoncpp include directory")

    find_library(
        JSONCPP_LIBRARY
        NAMES jsoncpp
    )

endif (JSONCPP_INCLUDE_DIR AND JSONCPP_LIBRARY)


FIND_PACKAGE_HANDLE_STANDARD_ARGS(JsonCPP DEFAULT_MSG JSONCPP_INCLUDE_DIR JSONCPP_LIBRARY)
mark_as_advanced(JSONCPP_INCLUDE_DIR JSONCPP_LIBRARY)

include(FindPackageHandleStandardArgs)

if (ETHKEY_INCLUDE_DIR AND ETHKEY_LIBRARY)
    set(EthKey_FIND_QUIETLY TRUE)

else (ETHKEY_INCLUDE_DIR AND ETHKEY_LIBRARY)
    set(EthKey_FIND_QUIETLY FALSE)

    if (WIN32)
        FIND_PATH(ETHKEY_INCLUDE_DIR ethkey/KeyPair.hpp
            PATHS
            ${ETHKEY_PATH}/include
            $ENV{PROGRAMFILES}/ethkey
            DOC "The directory where ethkey/KeyPair.hpp resides")
        FIND_LIBRARY(ETHKEY_LIBRARY
            NAMES ethkey
            PATHS
            ${ETHKEY_PATH}
            $ENV{PROGRAMFILES}/ethkey
            DOC "The ethkey library")
    else (WIN32)
        FIND_PATH(ETHKEY_INCLUDE_DIR ethkey/KeyPair.hpp
            PATHS
            ${ETHKEY_PATH}/include
            /usr/local/include
            /usr/include
            /sw/include
            /opt/local/include
            DOC "The directory where libethkey/KeyPair.hpp resides")
        FIND_LIBRARY(ETHKEY_LIBRARY
            NAMES ethkey
            PATHS
            ${ETHKEY_PATH}
            /usr/local/lib64
            /usr/local/lib
            /usr/lib64
            /usr/lib
            /sw/lib
            /opt/local/lib
            DOC "The ethkey library")
    endif (WIN32)
endif (ETHKEY_INCLUDE_DIR AND ETHKEY_LIBRARY)


FIND_PACKAGE_HANDLE_STANDARD_ARGS(EthKey DEFAULT_MSG ETHKEY_INCLUDE_DIR ETHKEY_LIBRARY)
mark_as_advanced (ETHKEY_INCLUDE_DIR ETHKEY_LIBRARY)


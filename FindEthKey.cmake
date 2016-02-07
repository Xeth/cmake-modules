
IF(NOT ETHKEY_INCLUDE_DIR)
IF (WIN32)
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
ELSE (WIN32)
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
ENDIF (WIN32)
ENDIF(NOT ETHKEY_INCLUDE_DIR)


IF (ETHKEY_INCLUDE_DIR)
    SET(ETHKEY_FOUND 1)
ELSE (ETHKEY_INCLUDE_DIR)
    SET(ETHKEY_FOUND 0)
ENDIF (ETHKEY_INCLUDE_DIR)

MARK_AS_ADVANCED( ETHKEY_FOUND )

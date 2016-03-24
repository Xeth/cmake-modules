include(FindPackageHandleStandardArgs)

if (ETHRPC_INCLUDE_DIR AND ETHRPC_LIBRARY)
    set(EthRPC_FIND_QUIETLY TRUE)

else (ETHRPC_INCLUDE_DIR AND ETHRPC_LIBRARY)
    set(EthRPC_FIND_QUIETLY FALSE)

    if (WIN32)
        FIND_PATH(ETHRPC_INCLUDE_DIR ethrpc/Provider.hpp.hpp
            PATHS
            ${ETHRPC_PATH}/include
            $ENV{PROGRAMFILES}/ethrpc
            DOC "The directory where ethrpc/Provider.hpp.hpp resides")
        FIND_LIBRARY(ETHRPC_LIBRARY
            NAMES ethrpc
            PATHS
            ${ETHRPC_PATH}
            $ENV{PROGRAMFILES}/ethrpc
            DOC "The ethrpc library")
    else (WIN32)
        FIND_PATH(ETHRPC_INCLUDE_DIR ethrpc/Provider.hpp.hpp
            PATHS
            ${ETHRPC_PATH}/include
            /usr/local/include
            /usr/include
            /sw/include
            /opt/local/include
            DOC "The directory where libethrpc/Provider.hpp.hpp resides")
        FIND_LIBRARY(ETHRPC_LIBRARY
            NAMES ethrpc
            PATHS
            ${ETHRPC_PATH}
            /usr/local/lib64
            /usr/local/lib
            /usr/lib64
            /usr/lib
            /sw/lib
            /opt/local/lib
            DOC "The ethrpc library")
    endif (WIN32)
endif (ETHRPC_INCLUDE_DIR AND ETHRPC_LIBRARY)


FIND_PACKAGE_HANDLE_STANDARD_ARGS(EthRPC DEFAULT_MSG ETHRPC_INCLUDE_DIR ETHRPC_LIBRARY)
mark_as_advanced (ETHRPC_INCLUDE_DIR ETHRPC_LIBRARY)


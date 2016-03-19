include(FindPackageHandleStandardArgs)

if (ETHCRYPTO_INCLUDE_DIR AND ETHCRYPTO_LIBRARY)
    set(EthCrypto_FIND_QUIETLY TRUE)

else (ETHCRYPTO_INCLUDE_DIR AND ETHCRYPTO_LIBRARY)
    set(EthCrypto_FIND_QUIETLY FALSE)

    if (WIN32)
        FIND_PATH(ETHCRYPTO_INCLUDE_DIR ethcrypto/key/KeyPair.hpp
            PATHS
            ${ETHCRYPTO_PATH}/include
            $ENV{PROGRAMFILES}/ethcrypto
            DOC "The directory where ethcrypto/key/KeyPair.hpp resides")
        FIND_LIBRARY(ETHCRYPTO_LIBRARY
            NAMES ethcrypto
            PATHS
            ${ETHCRYPTO_PATH}
            $ENV{PROGRAMFILES}/ethcrypto
            DOC "The ethcrypto library")
    else (WIN32)
        FIND_PATH(ETHCRYPTO_INCLUDE_DIR ethcrypto/key/KeyPair.hpp
            PATHS
            ${ETHCRYPTO_PATH}/include
            /usr/local/include
            /usr/include
            /sw/include
            /opt/local/include
            DOC "The directory where libethcrypto/key/KeyPair.hpp resides")
        FIND_LIBRARY(ETHCRYPTO_LIBRARY
            NAMES ethcrypto
            PATHS
            ${ETHCRYPTO_PATH}
            /usr/local/lib64
            /usr/local/lib
            /usr/lib64
            /usr/lib
            /sw/lib
            /opt/local/lib
            DOC "The ethcrypto library")
    endif (WIN32)
endif (ETHCRYPTO_INCLUDE_DIR AND ETHCRYPTO_LIBRARY)


FIND_PACKAGE_HANDLE_STANDARD_ARGS(EthCrypto DEFAULT_MSG ETHCRYPTO_INCLUDE_DIR ETHCRYPTO_LIBRARY)
mark_as_advanced (ETHCRYPTO_INCLUDE_DIR ETHCRYPTO_LIBRARY)


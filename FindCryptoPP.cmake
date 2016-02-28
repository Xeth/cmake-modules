include(FindPackageHandleStandardArgs)

if (CRYPTOPP_INCLUDE_DIR AND CRYPTOPP_LIBRARY)
    set(CryptoPP_FIND_QUIETLY TRUE)
else (CRYPTOPP_INCLUDE_DIR AND CRYPTOPP_LIBRARY)
    set(CryptoPP_FIND_QUIETLY FALSE)

    find_path (CRYPTOPP_ROOT_DIR
      NAMES cryptopp/cryptlib.h include/cryptopp/cryptlib.h
      PATHS ENV CRYPTOPPROOT
      DOC "CryptoPP root directory")

    find_path (CRYPTOPP_INCLUDE_DIR
      NAMES cryptopp/cryptlib.h
      HINTS ${CRYPTOPP_ROOT_DIR}
      PATH_SUFFIXES include
      DOC "CryptoPP include directory")

    find_library (CRYPTOPP_LIBRARY
      NAMES cryptlib cryptopp
      HINTS ${CRYPTOPP_ROOT_DIR}
      PATH_SUFFIXES lib
      DOC "CryptoPP release library")
endif (CRYPTOPP_INCLUDE_DIR AND CRYPTOPP_LIBRARY)



FIND_PACKAGE_HANDLE_STANDARD_ARGS(CryptoPP DEFAULT_MSG CRYPTOPP_INCLUDE_DIR CRYPTOPP_LIBRARY)
MARK_AS_ADVANCED (CRYPTOPP_INCLUDE_DIR CRYPTOPP_LIBRARY)


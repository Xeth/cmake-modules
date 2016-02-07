function (CopyHeaders)
    file(GLOB_RECURSE HEADERS RELATIVE ${CMAKE_CURRENT_SOURCE_DIR}/src
        "src/*.hpp"
        "src/*.ipp"
    )
    foreach(HEADER ${HEADERS})
        set(HEADER_PATH ${CMAKE_CURRENT_SOURCE_DIR}/src/${HEADER})
        configure_file(${HEADER_PATH} ${CMAKE_CURRENT_BINARY_DIR}/include/${CMAKE_PROJECT_NAME}/${HEADER} @ONLY)
    endforeach(HEADER)
endfunction()

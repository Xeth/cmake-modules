function(GENERATE_QRC)

    PARSE_ARGUMENTS("TARGET;ROOT_PATH" "RESOURCES" ${ARGN})

    set(QRC_PATH ${PROJECT_BINARY_DIR}/resources/${TARGET}.qrc)
    set_source_files_properties(${QRC_PATH} PROPERTIES GENERATED TRUE)

    set(RESOURCE_FILES "")

    if(ROOT_PATH)
        get_filename_component(ROOT_PATH ${ROOT_PATH} ABSOLUTE)
        set(ROOT_PATH ${ROOT_PATH}/)
    endif()


    foreach(RESOURCE ${RESOURCES})
        file(GLOB_RECURSE FILES ${ROOT_PATH}${RESOURCE}/*)
        list(APPEND RESOURCE_FILES ${FILES})
    endforeach()

    set(QRC_FILE_CONTENT "<RCC>\r\n  <qresource prefix=\"/\"> ")
    string(LENGTH ${ROOT_PATH} ROOT_LENGTH)
    foreach(RESOURCE_FILE ${RESOURCE_FILES})
        #strip root path
        string(LENGTH ${RESOURCE_FILE} FILEPATH_LENGTH)
        string(SUBSTRING ${RESOURCE_FILE} ${ROOT_LENGTH} ${FILEPATH_LENGTH} RESOURCE_NAME)
        set(QRC_FILE_CONTENT "${QRC_FILE_CONTENT}\r\n    <file alias=\"${RESOURCE_NAME}\">${RESOURCE_FILE}</file>")
    endforeach()
    set(QRC_FILE_CONTENT "${QRC_FILE_CONTENT}\r\n  </qresource>\r\n</RCC>")
    file(WRITE ${QRC_PATH} ${QRC_FILE_CONTENT})
endfunction()




function(COMPILE_QRC)
    PARSE_ARGUMENTS("TARGET" "DEPENDS" ${ARGN})
    set(RESOURCE_CPP ${PROJECT_BINARY_DIR}/${TARGET}.cxx)
    set_source_files_properties(${RESOURCE_CPP} PROPERTIES GENERATED TRUE)
    if(DEPENDS)
        add_custom_command(OUTPUT ${RESOURCE_CPP} COMMAND ${Qt5Core_RCC_EXECUTABLE} ${rcc_options} -name ${TARGET} -o ${RESOURCE_CPP} ${PROJECT_BINARY_DIR}/resources/${TARGET}.qrc DEPENDS ${DEPENDS})
    else()
        add_custom_command(OUTPUT ${RESOURCE_CPP} COMMAND ${Qt5Core_RCC_EXECUTABLE} ${rcc_options} -name ${TARGET} -o ${RESOURCE_CPP} ${PROJECT_BINARY_DIR}/resources/${TARGET}.qrc )
    endif()
    add_custom_target(${TARGET} DEPENDS ${RESOURCE_CPP}) 
endfunction()


function(ADD_QRC)
    GENERATE_QRC(${ARGN})
    COMPILE_QRC(${ARGN})
endfunction()




function(GENERATE_QRC RCC_NAME ROOT_PATH DIRS)
    set_source_files_properties(${PROJECT_BINARY_DIR}/resources/${RCC_NAME}.rcc PROPERTIES GENERATED TRUE)
    set(DIRS ${DIRS} ${ARGN})
    set(RESOURCE_FILES "")

    if(ROOT_PATH)
        get_filename_component(ROOT_PATH ${ROOT_PATH} ABSOLUTE)
        set(ROOT_PATH ${ROOT_PATH}/)
    endif()


    foreach(DIR ${DIRS})
        file(GLOB_RECURSE DIR_FILES ${ROOT_PATH}${DIR}/*)
        list(APPEND RESOURCE_FILES ${DIR_FILES})
    endforeach(DIR)

    set(QRC_FILE_CONTENT "<RCC>\r\n  <qresource prefix=\"/\"> ")
    string(LENGTH ${ROOT_PATH} ROOT_LENGTH)
    foreach(RESOURCE_FILE ${RESOURCE_FILES})
        #strip root path
        string(LENGTH ${RESOURCE_FILE} FILEPATH_LENGTH)
        string(SUBSTRING ${RESOURCE_FILE} ${ROOT_LENGTH} ${FILEPATH_LENGTH} RESOURCE_NAME)
        set(QRC_FILE_CONTENT "${QRC_FILE_CONTENT}\r\n    <file alias=\"${RESOURCE_NAME}\">${RESOURCE_FILE}</file>")
    endforeach(RESOURCE_FILE)
    set(QRC_FILE_CONTENT "${QRC_FILE_CONTENT}\r\n  </qresource>\r\n</RCC>")
    file(WRITE ${PROJECT_BINARY_DIR}/resources/${RCC_NAME}.qrc ${QRC_FILE_CONTENT})
endfunction(GENERATE_QRC)




function(PARSE_RESOURCES_TARGET TARGET_NAME RESOURCE_FILES IN_DIR OUT_DIR EXT PARSER)

    file(GLOB IN_DIR ${IN_DIR})
    file(GLOB OUT_DIR ${OUT_DIR})
    file(GLOB_RECURSE FILES "${IN_DIR}/*.${EXT}")
    set(GENERATED_FILES "")

    foreach(FILE_PATH ${FILES})
        string(REPLACE ${IN_DIR} "" FILE_NAME "${FILE_PATH}")
        set(PARSED_NAME ${OUT_DIR}${FILE_NAME})
        list(APPEND GENERATED_FILES ${PARSED_NAME})
    endforeach()


    set_source_files_properties(${GENERATED_FILES} PROPERTIES GENERATED TRUE)
    add_custom_target(${TARGET_NAME} COMMAND ${PARSER} ${IN_DIR} ${OUT_DIR} DEPENDS ${PARSER})

endfunction(PARSE_RESOURCES_TARGET)

function(COMPILE_QRC_TARGET RESOURCE)
    set(RESOURCE_CPP ${PROJECT_BINARY_DIR}/${RESOURCE}.cxx)
    set_source_files_properties(${RESOURCE_CPP} PROPERTIES GENERATED TRUE)
    add_custom_target(compile_${RESOURCE} COMMAND ${Qt5Core_RCC_EXECUTABLE} ${rcc_options} -name ${RESOURCE} -o ${RESOURCE_CPP} ${PROJECT_BINARY_DIR}/resources/${RESOURCE}.qrc)
endfunction(COMPILE_QRC_TARGET)

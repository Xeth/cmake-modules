function(GENERATE_QRC QRC_NAME)

    set(oneValueArgs ROOT_PATH)
    set(multiValueArgs RESOURCES)
    cmake_parse_arguments(QRC "" "${oneValueArgs}" "${multiValueArgs}" ${ARGN} )


    set(QRC_PATH ${PROJECT_BINARY_DIR}/resources/${QRC_NAME}.rcc)
    set_source_files_properties(${QRC_PATH} PROPERTIES GENERATED TRUE)

    set(RESOURCE_FILES "")

    if(QRC_ROOT_PATH)
        get_filename_component(ROOT_PATH ${QRC_ROOT_PATH} ABSOLUTE)
        set(QRC_ROOT_PATH ${QRC_ROOT_PATH}/)
    endif()


    foreach(RESOURCE ${QRC_RESOURCES})
        file(GLOB_RECURSE FILES ${QRC_ROOT_PATH}${RESOURCE}/*)
        list(APPEND RESOURCE_FILES ${FILES})
    endforeach()

    set(QRC_FILE_CONTENT "<RCC>\r\n  <qresource prefix=\"/\"> ")
    string(LENGTH ${QRC_ROOT_PATH} ROOT_LENGTH)
    foreach(RESOURCE_FILE ${RESOURCE_FILES})
        #strip root path
        string(LENGTH ${RESOURCE_FILE} FILEPATH_LENGTH)
        string(SUBSTRING ${RESOURCE_FILE} ${ROOT_LENGTH} ${FILEPATH_LENGTH} RESOURCE_NAME)
        set(QRC_FILE_CONTENT "${QRC_FILE_CONTENT}\r\n    <file alias=\"${RESOURCE_NAME}\">${RESOURCE_FILE}</file>")
    endforeach()
    set(QRC_FILE_CONTENT "${QRC_FILE_CONTENT}\r\n  </qresource>\r\n</RCC>")
    file(WRITE ${QRC_PATH} ${QRC_FILE_CONTENT})
endfunction(GENERATE_QRC)




function(ADD_PARSE_RESOURCES_TARGET TARGET_NAME RESOURCE_FILES IN_DIR OUT_DIR EXT PARSER)

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
    add_custom_target(${TARGET_NAME} ALL)
    add_custom_command(TARGET ${TARGET_NAME} COMMAND ${PARSER} ${IN_DIR} ${OUT_DIR} DEPENDS ${PARSER})

endfunction()

function(ADD_QRC_COMPILE_TARGET RESOURCE)
    set(RESOURCE_CPP ${PROJECT_BINARY_DIR}/${RESOURCE}.cxx)
    set(TARGET_NAME compile_${RESOURCE})
    set_source_files_properties(${RESOURCE_CPP} PROPERTIES GENERATED TRUE)
#    add_custom_target(${TARGET_NAME} ALL)
    add_custom_command(OUTPUT ${RESOURCE_CPP} COMMAND ${Qt5Core_RCC_EXECUTABLE} ${rcc_options} -name ${RESOURCE} -o ${RESOURCE_CPP} ${PROJECT_BINARY_DIR}/resources/${RESOURCE}.qrc )
endfunction()


function(ADD_QRC_TARGET RESOURCE_NAME )
    GENERATE_QRC(${RESOURCE_NAME}  ${ARGN})
    ADD_QRC_COMPILE_TARGET(${RESOURCE_NAME})
endfunction()




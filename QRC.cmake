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


function(PARSE_QRC RESOURCE_FILES DIR QRC PARSER)

    file(GLOB DIR_PATH "resources/${DIR}")
    file(GLOB QRC_PATH "resources")
    set(QRC_PATH "${QRC_PATH}/${QRC}.qrc")

    list(REMOVE_ITEM ${RESOURCE_FILES} ${DIR_PATH})
    list(REMOVE_ITEM ${RESOURCE_FILES} ${QRC_PATH})

    file(GLOB_RECURSE FILES "${PROJECT_SOURCE_DIR}/resources/${DIR}/*")

    set(GENERATED_FILES "")

    foreach(FILE_PATH ${FILES})
        string(REPLACE ${DIR_PATH} "" FILE_NAME "${FILE_PATH}")
        set(PARSED_NAME ${PROJECT_BINARY_DIR}/resources/${DIR}${FILE_NAME})
        list(APPEND GENERATED_FILES ${PARSED_NAME})
    endforeach()

    set(OUT_DIR ${PROJECT_BINARY_DIR}/resources/${DIR})
    set(OUT_QRC ${PROJECT_BINARY_DIR}/resources/${QRC}.qrc)
    file(MAKE_DIRECTORY ${OUT_DIR})
    set(PARSED_CPP ${PROJECT_BINARY_DIR}/${DIR}.cxx)
    set_source_files_properties(${GENERATED_FILES} PROPERTIES GENERATED TRUE)
    set_source_files_properties(${PARSED_CPP} PROPERTIES GENERATED TRUE)

    add_custom_target(parse_${DIR}_files COMMAND ${PARSER} ${DIR_PATH} ${OUT_DIR} DEPENDS ${PARSER})
#    add_custom_target(parse_${DIR}_qrc COMMAND  ${CMAKE_COMMAND} -E copy ${QRC_PATH} ${CMAKE_BINARY_DIR}/resources DEPENDS parse_${DIR}_files)
    add_custom_target(parse_${DIR} COMMAND ${Qt5Core_RCC_EXECUTABLE} ${rcc_options} -name ${QRC} -o ${PARSED_CPP} ${OUT_QRC} DEPENDS parse_${DIR}_files)

endfunction(PARSE_QRC)

function(COMPILE_QRC RESOURCE)
    set(RESOURCE_CPP ${PROJECT_BINARY_DIR}/${RESOURCE}.cxx)
    set_source_files_properties(${RESOURCE_CPP} PROPERTIES GENERATED TRUE)
    add_custom_target(compile_${RESOURCE} COMMAND ${Qt5Core_RCC_EXECUTABLE} ${rcc_options} -name ${RESOURCE} -o ${RESOURCE_CPP} ${PROJECT_BINARY_DIR}/resources/${RESOURCE}.qrc)
endfunction(COMPILE_QRC)

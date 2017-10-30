


function(JOIN VALUES GLUE OUTPUT)
  string (REGEX REPLACE "([^\\]|^);" "\\1${GLUE}" _TMP_STR "${VALUES}")
  string (REGEX REPLACE "[\\](.)" "\\1" _TMP_STR "${_TMP_STR}") #fixes escaping
  set (${OUTPUT} "${_TMP_STR}" PARENT_SCOPE)
endfunction()



function(PARSE_ARGUMENTS oneValueArgs multiValueArgs)

    cmake_parse_arguments(ARG "" "${oneValueArgs}" "${multiValueArgs}" ${ARGN} )
    foreach(VARIABLE_NAME ${oneValueArgs} ${multiValueArgs})
        set(ARG_NAME ARG_${VARIABLE_NAME})
        set(VARIABLE_VALUE ${${ARG_NAME}})
        set(${VARIABLE_NAME} ${VARIABLE_VALUE})
        set(${VARIABLE_NAME} ${VARIABLE_VALUE} PARENT_SCOPE)
    endforeach()
    
endfunction()

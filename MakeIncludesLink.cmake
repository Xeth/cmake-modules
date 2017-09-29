function (MakeIncludesLink)
    file(MAKE_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/include)
    execute_process(COMMAND ${CMAKE_COMMAND} -E create_symlink ${CMAKE_CURRENT_SOURCE_DIR}/src ${CMAKE_CURRENT_BINARY_DIR}/include/${PROJECT_NAME})
endfunction()

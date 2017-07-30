function (MakeIncludesLink)
    ADD_CUSTOM_TARGET(${PROJECT_NAME}_link_headers ALL COMMAND ${CMAKE_COMMAND} -E create_symlink ${CMAKE_CURRENT_SOURCE_DIR}/src ${CMAKE_CURRENT_BINARY_DIR}/include/${PROJECT_NAME})
endfunction()

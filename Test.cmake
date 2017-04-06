include(${CMAKE_CURRENT_LIST_DIR}/Utils.cmake)

function(ADD_TEST_TARGET TARGET_NAME)
    add_test(build_${TARGET_NAME} "${CMAKE_COMMAND}" --build ${CMAKE_BINARY_DIR} --target ${TARGET_NAME})
    list(LENGTH ARGN ARG_CNT)
    if(ARG_CNT GREATER 0)
        list(GET ARGN 0 WORKING_DIRECTORY)
        add_test(NAME run_${TARGET_NAME} COMMAND ${TARGET_NAME} WORKING_DIRECTORY ${WORKING_DIRECTORY})
    else()
        add_test(NAME run_${TARGET_NAME} COMMAND ${TARGET_NAME})
    endif()
    set_tests_properties(run_${TARGET_NAME} PROPERTIES DEPENDS build_${TARGET_NAME})
endfunction(ADD_TEST_TARGET)


function(GENERATE_QT_TEST_MAIN CPP_MAIN TEST_CASE_DIR)

    file(GLOB_RECURSE TEST_FILES ${TEST_CASE_DIR}/*.hpp)
    set(INCLUDES "#include <QTest>\n#include <iostream>\n#include <boost/preprocessor/variadic/to_seq.hpp>\n#include <boost/preprocessor/seq/for_each.hpp>")
    set(TEST_LIST "")

    foreach(TEST_FILE ${TEST_FILES})
        set(INCLUDES "${INCLUDES}\n#include \"${TEST_FILE}\"")
        get_filename_component(TEST_NAME ${TEST_FILE} NAME_WE)
        list(APPEND TEST_LIST ${TEST_NAME})
    endforeach()

    JOIN("${TEST_LIST}" "," TEST_LIST)


    set(SOURCE_CODE "${INCLUDES}\n\
template<class Test>                                                             \n\
int ExecuteTest(int argc, char **argv)                                           \n\
{                                                                                \n\
    Test test\;                                                                  \n\
    return QTest::qExec(&test, argc, argv)\;                                     \n\
}                                                                                \n\
                                                                                 \n\
#define EXECUTE_TEST(r, data, Test) ||ExecuteTest<Test>(argc, argv)              \n\
#define RUN_TEST_SEQ(seq) 0 BOOST_PP_SEQ_FOR_EACH(EXECUTE_TEST,, seq )           \n\
#define RUN_TESTS(...) RUN_TEST_SEQ(BOOST_PP_VARIADIC_TO_SEQ (__VA_ARGS__))      \n\
int main(int argc, char** argv)                                                  \n\
{                                                                                \n\
    int status = RUN_TESTS(${TEST_LIST})\;                                       \n\
    if(status)                                                                   \n\
    {                                                                            \n\
        std::cout<<\"\\nUnit-Test failed\\n\"\;                                  \n\
    }                                                                            \n\
    return status\;                                                              \n\
}                                                                                \n\
")
    file(WRITE ${CPP_MAIN} ${SOURCE_CODE})

endfunction(GENERATE_QT_TEST_MAIN)



enable_testing()




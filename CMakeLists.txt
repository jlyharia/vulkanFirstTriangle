cmake_minimum_required(VERSION 3.31)
project(firstTriangle)

include(${PROJECT_SOURCE_DIR}/cmake/macro.cmake)
set(CMAKE_DEFAULT_MODULE_LIST /opt/homebrew/opt/cmake/share/cmake/Modules)
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${CMAKE_SOURCE_DIR}/cmake/modules)
set(HOMEBREW_INCLUDE_PATH /opt/homebrew/include)
set(HOMEBREW_LIB_PATH /opt/homebrew/libs)

message("-- CMAKE_DEFAULT_MODULE_LIST: " ${CMAKE_DEFAULT_MODULE_LIST})

include_module(GLFW)
include_module(GLM)
include_module(Vulkan)

set(CMAKE_CXX_STANDARD 23)

message("-- HEADER_FILES: " ${HEADER_FILES})
message("-- SOURCE_FILES: " ${SOURCE_FILES})
message("-- Libraries: " ${LIBRARIES})
message("-- CMAKE_SOURCE_DIR " ${CMAKE_SOURCE_DIR})
message("-- CMAKE_COMMAND " ${CMAKE_COMMAND})

# add_custom_command only run when cmake build
# add_custom_command(
#         OUTPUT ${CMAKE_BINARY_DIR}/output.txt
#         COMMAND ${CMAKE_COMMAND} -E echo "=== Compile GLSL file into SPIR-V ==="
#         COMMAND ${CMAKE_COMMAND} -E env bash ${CMAKE_SOURCE_DIR}/compile.sh
#         WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
# )
# add_custom_target(
#         generate_output ALL
#         DEPENDS ${CMAKE_BINARY_DIR}/output.txt)

# execute_process run every time during cmake reload
execute_process(
        COMMAND bash ${CMAKE_SOURCE_DIR}/compile.sh
        WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
)
add_executable(firstTriangle main.cpp ${SOURCE_FILES}
        Utils.hpp)
target_link_libraries(${PROJECT_NAME} ${LIBRARIES})
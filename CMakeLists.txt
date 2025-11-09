cmake_minimum_required(VERSION 4.1)
project(firstTriangle)

include(${PROJECT_SOURCE_DIR}/cmake/macro.cmake)
if(APPLE)
        set(CMAKE_DEFAULT_MODULE_LIST /opt/homebrew/opt/cmake/share/cmake/Modules)
        set(HOMEBREW_INCLUDE_PATH /opt/homebrew/include)
        set(HOMEBREW_LIB_PATH /opt/homebrew/libs)
else()
        set(CMAKE_DEFAULT_MODULE_LIST /opt/cmake/share/cmake-4.1/Modules)
        set(HOMEBREW_INCLUDE_PATH /usr/include /usr/local/include)
        set(HOMEBREW_LIB_PATH /usr/lib /usr/local/lib)
endif(APPLE)
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${CMAKE_SOURCE_DIR}/cmake/modules)


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
if(APPLE)
        execute_process(
                COMMAND bash ${CMAKE_SOURCE_DIR}/compile.sh
                WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
        )
else()
        execute_process(
                COMMAND bash ${CMAKE_SOURCE_DIR}/compile-linux.sh
                WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
        )
endif()



add_executable(firstTriangle main.cpp Vertex.hpp ${SOURCE_FILES})
target_link_libraries(firstTriangle ${LIBRARIES})
include_directories(${CMAKE_SOURCE_DIR})

# copy texture, put this after add_executable(..) 
add_custom_command(
        TARGET firstTriangle POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy_directory
        ${CMAKE_SOURCE_DIR}/textures
        $<TARGET_FILE_DIR:firstTriangle>/textures
        COMMENT "Copying textures folder to build directory"
)

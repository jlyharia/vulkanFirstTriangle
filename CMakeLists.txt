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

add_executable(firstTriangle main.cpp ${SOURCE_FILES}
        Utils.hpp)
target_link_libraries(${PROJECT_NAME} ${LIBRARIES})
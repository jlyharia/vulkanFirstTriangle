cmake_minimum_required(VERSION 4.1)
project(firstTriangle)

set(TARGET_NAME firstTriangle)
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


# add_executable(firstTriangle main.cpp Vertex.hpp external/tiny_obj_loader.h ${SOURCE_FILES})
# target_link_libraries(firstTriangle ${LIBRARIES})
# include_directories(${CMAKE_SOURCE_DIR})

add_executable(firstTriangle
    main.cpp
    ${SOURCE_FILES}
)

target_include_directories(firstTriangle
    PRIVATE ${CMAKE_SOURCE_DIR}
    PRIVATE ${CMAKE_SOURCE_DIR}/external
)

target_link_libraries(firstTriangle
    PRIVATE ${LIBRARIES}
)


# copy assets, models, texture ...etc put this after add_executable(..) 
add_custom_command(
        TARGET ${TARGET_NAME} POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy_directory
        ${CMAKE_SOURCE_DIR}/assets
        $<TARGET_FILE_DIR:firstTriangle>/assets
        COMMENT "Copying textures folder to build directory"
)

# Ensure build/shaders folder exists
file(MAKE_DIRECTORY ${CMAKE_BINARY_DIR}/shaders)

# Find glslangValidator
find_program(GLSLANG_VALIDATOR glslangValidator)
if(NOT GLSLANG_VALIDATOR)
        message(FATAL_ERROR "glslangValidator not found! Make sure Vulkan SDK is installed.")
endif()

# GLSL → SPV
add_custom_command(
        OUTPUT ${CMAKE_BINARY_DIR}/shaders/vert.spv
        COMMAND ${GLSLANG_VALIDATOR} -V ${CMAKE_SOURCE_DIR}/shaders/09_shader_base.vert -o ${CMAKE_BINARY_DIR}/shaders/vert.spv
        DEPENDS ${CMAKE_SOURCE_DIR}/shaders/09_shader_base.vert
)

add_custom_command(
        OUTPUT ${CMAKE_BINARY_DIR}/shaders/frag.spv
        COMMAND ${GLSLANG_VALIDATOR} -V ${CMAKE_SOURCE_DIR}/shaders/09_shader_base.frag -o ${CMAKE_BINARY_DIR}/shaders/frag.spv
        DEPENDS ${CMAKE_SOURCE_DIR}/shaders/09_shader_base.frag
)

add_custom_command(
        OUTPUT ${CMAKE_BINARY_DIR}/shaders/comp.spv
        COMMAND ${GLSLANG_VALIDATOR} -V ${CMAKE_SOURCE_DIR}/shaders/31_shader_base.comp -o ${CMAKE_BINARY_DIR}/shaders/comp.spv
        DEPENDS ${CMAKE_SOURCE_DIR}/shaders/31_shader_base.comp
)

add_custom_target(Shaders ALL DEPENDS
        ${CMAKE_BINARY_DIR}/shaders/vert.spv
        ${CMAKE_BINARY_DIR}/shaders/frag.spv
        ${CMAKE_BINARY_DIR}/shaders/comp.spv
)

add_dependencies(firstTriangle Shaders)

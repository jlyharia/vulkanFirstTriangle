# Try to find GLFW library
# Once done this will define
#  GLFW_FOUND - if system found GLFW library
#  GLFW_INCLUDE_DIRS - The GLFW include directories
#  GLFW_LIBRARS - The libraries needed to use GLFW
#  GLFW_DEFINITIONS - Compiler switches required for using GLFW

IF (WIN32)
    FIND_PATH(GLFW_INCLUDE_DIRS GLFW/glfw3.h
            $ENV{PROGRAMFILES}/usr/include
            ${PROJECT_SOURCE_DIR}/usr/include
            DOC "The directory where GLFW/glfw3.h resides")
    FIND_LIBRARY(GLFW_LIBRARIES
            NAMES
            glfw
            glfw3
            PATHS
            $ENV{PROGRAMFILES}/usr/lib
            ${PROJECT_SOURCE_DIR}/usr/bin
            ${PROJECT_SOURCE_DIR}/usr/lib
            DOC "The GLFW library")

elseif (APPLE)
    find_path(GLFW_INCLUDE_DIRS
            NAMES GLFW/glfw3.h
            PATHS ${HOMEBREW_INCLUDE_PATH}
            DOC "The boost include directory")

    find_library(GLFW_LIBRARIES
            NAMES
            glfw
            PATHS ${HOMEBREW_LIB_PATH}
            DOC "The GLFW library")
ELSE ()
    message(STATUS "Building on other platform")
ENDIF (WIN32)

include(${CMAKE_DEFAULT_MODULE_LIST}/FindPackageHandleStandardArgs.cmake)
# handle the QUIETLY and REQUIRED arguments and set LOGGING_FOUND to TRUE
# if all listed variables are TRUE
find_package_handle_standard_args(GLFW DEFAULT_MSG GLFW_INCLUDE_DIRS GLFW_LIBRARIES)

if (GLFW_FOUND)
    set(GLFW_LIBRARIES ${GLFW_LIBRARIES})
    set(GLFW_INCLUDE_DIRS ${GLFW_INCLUDE_DIRS})
    set(GLFW_DEFINITIONS)
endif ()

# Tell cmake GUIs to ignore the "local" variables.
mark_as_advanced(GLFW_INCLUDE_DIRS GLFW_LIBRARIES)
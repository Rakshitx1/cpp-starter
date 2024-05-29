cmake_minimum_required(VERSION 3.10)

# Define the project name as a variable
set(PROJECT_NAME Template)

project(${PROJECT_NAME} VERSION 1.0 LANGUAGES C CXX)

# Set C++ standard
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Set C standard
set(CMAKE_C_STANDARD 17)
set(CMAKE_C_STANDARD_REQUIRED ON)

# Print the C++ and C standard versions
message(STATUS "Using C++ standard version ${CMAKE_CXX_STANDARD}")
message(STATUS "Using C standard version ${CMAKE_C_STANDARD}")

# Set the build type to Debug by default if not specified
if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Debug)
endif()

# Output directories
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_DEBUG ${CMAKE_BINARY_DIR}/Debug)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_RELEASE ${CMAKE_BINARY_DIR}/Release)

# List your source files using GLOB
file(GLOB SOURCES
    "${CMAKE_CURRENT_LIST_DIR}/src/*.cpp"
    "${CMAKE_CURRENT_LIST_DIR}/src/*.c"
)

# List your header files using GLOB
file(GLOB HEADERS
    "${CMAKE_CURRENT_LIST_DIR}/inc/*.hpp"
    "${CMAKE_CURRENT_LIST_DIR}/inc/*.h"
)

# Create an executable
add_executable(${PROJECT_NAME} ${SOURCES} ${HEADERS})

# Include directories
target_include_directories(${PROJECT_NAME} PRIVATE
    "${CMAKE_CURRENT_LIST_DIR}/inc"
)

# Set compiler flags for Debug
target_compile_options(${PROJECT_NAME} PRIVATE $<$<CONFIG:DEBUG>: -O0 -g -Wall>)

# Set compiler flags for Release
target_compile_options(${PROJECT_NAME} PRIVATE $<$<CONFIG:RELEASE>: -O3>)

# Write the project name to a configuration file
file(WRITE "${CMAKE_BINARY_DIR}/project_config.sh" "PROJECT_NAME=${PROJECT_NAME}\n")

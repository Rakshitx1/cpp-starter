#!/bin/bash

# Get the directory where this script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# Save the current directory
CURRENT_DIR=$(pwd)

# Navigate to the script directory
cd "$SCRIPT_DIR"

# Determine build type based on input argument
if [[ "${1,,}" == "release" || "${1,,}" == "r" ]]; then
    BUILD_TYPE="Release"
    echo -e "\033[34mBuilding in Release mode...\033[0m"
else
    BUILD_TYPE="Debug"
    echo -e "\033[34mBuilding in Debug mode...\033[0m"
fi

# Remove existing build directory if it exists
if [ -d "build" ]; then
    rm -rf build
fi

# Create a new build directory
mkdir -p build

# Navigate to the build directory
cd build

# Generate Makefiles and build the project with the specified build type
cmake -DCMAKE_BUILD_TYPE="$BUILD_TYPE" ..

# sleep 2

# Check if the configuration file exists
CONFIG_FILE="project_config.sh"
if [ ! -f "$CONFIG_FILE" ]; then
    echo -e "\033[34mConfiguration file not found: $CONFIG_FILE\033[0m"
    exit 1
fi

# Source the project configuration generated by CMake
source "$CONFIG_FILE"

# Build the project
make

# Return to the script directory
cd "$SCRIPT_DIR"

# Run the executable
if [ "$BUILD_TYPE" == "Release" ]; then
    ./build/Release/$PROJECT_NAME
else
    ./build/Debug/$PROJECT_NAME
fi

# check if any of the input is "b" then delete build dir
if [[ "${1,,}" == "b" || "${2,,}" == "b" ]]; then
    cd "$SCRIPT_DIR"
    rm -rf build
    echo -e "\033[34mBuild directory deleted.\033[0m"
fi

# Return to the initial directory
cd "$CURRENT_DIR"
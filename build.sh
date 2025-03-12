#!/bin/bash

# Set project directories
MEDIAAPP_DIR="MediaApp"
MEDIASERVER_DIR="MediaServer"

# Build Flutter project
echo "Building Media App..."
cd "$MEDIAAPP_DIR" || exit
flutter build linux
cd ../ || exit

echo "Building Media Server..."
cd "$MEDIASERVER_DIR" || exit
mkdir -p build && cd build
cmake ..
make -j$(nproc)
cd - || exit

echo "Build completed."
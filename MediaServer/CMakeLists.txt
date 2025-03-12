cmake_minimum_required(VERSION 3.13)
project(MediaServer)

set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(INCLUDE_DIRS
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_CURRENT_SOURCE_DIR}/common
)

file(GLOB_RECURSE SOURCES "${CMAKE_CURRENT_SOURCE_DIR}/common/*.cpp")

add_executable(${PROJECT_NAME} main.cpp mediaserver.cpp ${SOURCES})

target_link_libraries(${PROJECT_NAME} udev)
target_include_directories(${PROJECT_NAME} PUBLIC ${INCLUDE_DIRS})

cmake_minimum_required(VERSION 3.12)
project(ping-viewer LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CXX_STANDARD_REQUIRED ON)

set(QT_MIN_VERSION "5.12.0")

set(CMAKE_AUTOMOC ON)
set(AUTOMOC_MOC_OPTIONS -Muri=org.bluerobotics.pingviewer)

set(CMAKE_AUTORCC ON)

# Update submodules if necessary and load our GIT variables
include("cmake/git.cmake")

add_compile_definitions(
    QT_USE_QSTRINGBUILDER
    QT_NO_CAST_TO_ASCII
    QT_STRICT_ITERATORS
    QT_NO_CAST_FROM_BYTEARRAY
    QT_USE_FAST_OPERATOR_PLUS
)

find_package(Qt5 ${QT_MIN_VERSION} REQUIRED NO_MODULE COMPONENTS
    Charts
    Concurrent
    Core
    Network
    Qml
    Quick
    QuickControls2
    SerialPort
    Widgets
)

# global include directories
include_directories(
    lib/fmt/fmt/include/
    lib/ping-cpp/ping-cpp/src/message/
    lib/maddy/maddy/include/
    lib/mavlink/c_library_v2/
    lib/mavlink/c_library_v2/minimal
    lib/mavlink/c_library_v2/common
)

add_subdirectory(lib/fmt/fmt)

add_subdirectory(src)

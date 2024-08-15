cmake_minimum_required(VERSION 3.5)

# check build path rightful
if(${PROJECT_SOURCE_DIR} MATCHES ${PROJECT_BINARY_DIR})
  message(FATAL_ERROR "The build directory must not same as source directory")
endif()

# #############PARAMS##############
# set build mode: default Debug
set(CMAKE_BUILD_TYPE
    "Debug"
    CACHE STRING "CBD Target platform")
set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS "Debug;Release")
message(STATUS "Build with " ${CMAKE_BUILD_TYPE} " mode")

# set test mode: default true
set(CBD_TEST_ENABLE
    "ON"
    CACHE STRING "CBD Test Mode")
set_property(CACHE CBD_TEST_ENABLE PROPERTY STRINGS "FALSE;TRUE")
message(STATUS "Build with test " ${CBD_TEST_ENABLE} " mode")

# set platform type: default Linux-X64
set(CBD_TARGET_PLATFORM
    "Linux-X64"
    CACHE STRING "CBD Target platform")
set_property(CACHE CBD_TARGET_PLATFORM PROPERTY STRINGS "Linux-X64")
message(STATUS "Build with " ${CBD_TARGET_PLATFORM} " platform")

# set app type: default fdm
set(CBD_TARGET_APP
    "fdm"
    CACHE STRING "CBD Target app")
set_property(CACHE CBD_TARGET_APP PROPERTY STRINGS "fdm")
message(STATUS "Build with " ${CBD_TARGET_APP} " app")

# set build type: default STATIC
set(CBD_LIBRARY_TYPE
    "STATIC"
    CACHE STRING "CBD library type")
set_property(CACHE CBD_LIBRARY_TYPE PROPERTY STRINGS "SHARED;STATIC")
message(STATUS "Build with " ${CBD_LIBRARY_TYPE} " library")

# set force build single shared library
option(CBD_LIBRARY_FORCE_SINGLE
       "build shared library, but don't dependence other thrid party library"
       ON)
message(STATUS "Build with " ${CBD_LIBRARY_FORCE_SINGLE} " FORCE_SINGLE_LIBRARY")
# #############PARAMS##############

# set cmake files search path
set(CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/platforms")
# list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/platforms")
message(STATUS "CMAKE_MODULE_PATH: " ${CMAKE_MODULE_PATH})

# set project toolchain toolchain## search for programs in the build host
# directories
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
# for libraries and headers in the target directories
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)

if(CBD_TARGET_PLATFORM MATCHES "Linux-X86")
  set(CMAKE_C_COMPILER "/usr/bin/gcc")
  set(CMAKE_CXX_COMPILER "/usr/bin/g++")
  set(CBD_SYSTEM_NAME "Linux")
  set(CBD_SYSTEM_PROCESSOR "x86")
elseif(CBD_TARGET_PLATFORM MATCHES "Linux-X64")
  set(CMAKE_C_COMPILER "/usr/bin/gcc")
  set(CMAKE_CXX_COMPILER "/usr/bin/g++")
  set(CBD_SYSTEM_NAME "Linux")
  set(CBD_SYSTEM_PROCESSOR "x86_64")
elseif(CBD_TARGET_PLATFORM MATCHES "Linux-ARMV7")
  set(CMAKE_C_COMPILER "$ENV{CBD_ARMV7_TOOLCHAIN}/bin/arm-linux-gnueabihf-gcc")
  set(CMAKE_CXX_COMPILER
      "$ENV{CBD_ARMV7_TOOLCHAIN}/bin/arm-linux-gnueabihf-g++")
  set(CBD_SYSTEM_NAME "Linux")
  set(CBD_SYSTEM_PROCESSOR "armv7")
elseif(CBD_TARGET_PLATFORM MATCHES "Linux-ARM-OPENWRT")
  set(CMAKE_C_COMPILER
      "$ENV{CBD_ARM_OPENWRT_TOOLCHAIN}/bin/arm-openwrt-linux-gcc")
  set(CMAKE_CXX_COMPILER
      "$ENV{CBD_ARM_OPENWRT_TOOLCHAIN}/bin/arm-openwrt-linux-g++")
  set(CBD_SYSTEM_NAME "Linux")
  set(CBD_SYSTEM_PROCESSOR "openwrt")
elseif(CBD_TARGET_PLATFORM MATCHES "ARM-Cortex-M")
  set(CMAKE_C_COMPILER "$ENV{CBD_ARM_CORTEXM_TOOLCHAIN}/bin/arm-none-eabi-gcc")
  set(CMAKE_CXX_COMPILER
      "$ENV{CBD_ARM_CORTEXM_TOOLCHAIN}/bin/arm-none-eabi-g++")
  set(CBD_SYSTEM_NAME "RTOS")
  set(CBD_SYSTEM_PROCESSOR "cortex-m")
elseif(CBD_TARGET_PLATFORM MATCHES "RISC-V")
  set(CMAKE_C_COMPILER "$ENV{CBD_RISCV_TOOLCHAIN}/bin/riscv32-unknown-elf-gcc")
  set(CMAKE_CXX_COMPILER
      "$ENV{CBD_RISCV_TOOLCHAIN}/bin/riscv32-unknown-elf-g++")
  set(CBD_SYSTEM_NAME "RTOS")
  set(CBD_SYSTEM_PROCESSOR "risc-v")
else()
  message(FATAL_ERROR "Unsupported platform: " ${CBD_TARGET_PLATFORM})
endif()

# find source code and dependces according to choosed app type TODO:
if(CBD_TARGET_APP MATCHES "fdm")
  set(CBD_APP_NAME "fmd")
elseif(CBD_TARGET_APP MATCHES "lcd")
  set(CBD_APP_NAME "lcd")
elseif(CBD_TARGET_APP MATCHES "extruder")
  set(CBD_APP_NAME "extruder")
elseif(CBD_TARGET_APP MATCHES "motor")
  set(CBD_APP_NAME "motor")
elseif(CBD_TARGET_APP MATCHES "strain_gauge")
  set(CBD_APP_NAME "strain_gauge")
elseif(CBD_TARGET_APP MATCHES "ams")
  set(CBD_APP_NAME "ams")
else()
  message(FATAL_ERROR "Unsupported app: " ${CBD_TARGET_APP})
endif()

# set project name
project(thunderforge)

# add cmake files. common##

set(CMAKE_CXX_STANDARD 17)

# set compiler flags set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -O3 -Wall -pedantic")
# set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -O3 -Wall")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wno-attributes")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wno-sign-compare")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wno-write-strings")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wno-unused-function")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wno-unused-local-typedefs")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wno-strict-overflow")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Werror=switch")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Werror=return-type")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Werror=unused-variable")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Werror=uninitialized")
# set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -include common/global.h")

# set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -O3 -std=c++17")
# # set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -O3 -Wall -pedantic")
# set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -O3 -Wall")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -g -Wall")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wno-attributes")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wno-sign-compare")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wno-write-strings")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wno-unused-function")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wno-unused-local-typedefs")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wno-strict-overflow")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Werror=switch")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Werror=return-type")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Werror=switch")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Werror=return-type")
# set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Werror=unused-variable")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Werror=uninitialized")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wno-psabi")
# set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -include common/global.h")
if(CBD_SYSTEM_NAME MATCHES "Linux")
  set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -fPIC -fpie")
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fPIC -fpie")
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -static-libstdc++")
endif()

# set compiler path set source/build dir
set(CBD_BASE_DIR "${CMAKE_CURRENT_SOURCE_DIR}")
set(CBD_BUILD_DIR "${PROJECT_BINARY_DIR}")
set(CBD_OUTPUT_INCLUDE_DIR "${CBD_BUILD_DIR}/include")
set(CBD_OUTPUT_LIBRARY_DIR "${CBD_BUILD_DIR}/lib")
set(CBD_OUTPUT_BINARY_DIR "${CBD_BUILD_DIR}/bin")
set(CBD_OUTPUT_TEST_BINARY_DIR "${CBD_OUTPUT_BINARY_DIR}/test")
set(CBD_OUTPUT_SDK_BINARY_DIR "${CBD_OUTPUT_LIBRARY_DIR}/sdk")

# set default output path
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${CBD_OUTPUT_BINARY_DIR}")
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "${CBD_OUTPUT_LIBRARY_DIR}")
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY "${CBD_OUTPUT_LIBRARY_DIR}")

# set common dependence path
include_directories(${CBD_OUTPUT_INCLUDE_DIR})

# options## define compiler macro
if(CBD_SYSTEM_NAME MATCHES "Linux")
  add_definitions(-D__LINUX__)
elseif(CBD_SYSTEM_NAME MATCHES "Windows")
  add_definitions(-D__CBD_EXPORTS__)
  add_definitions(-D__WINDOW__)
else()
  message(FATAL_ERROR "Unsupported system: " ${CBD_SYSTEM_NAME})
endif()

# Debug/Release build
if(CMAKE_BUILD_TYPE MATCHES "Release")
  # Turn __DEBUG__ flag on.
  add_definitions(-D__RELEASE__)
elseif(CMAKE_BUILD_TYPE MATCHES "Debug")
  # Turn __DEBUG__ flag on.
  add_definitions(-D__DEBUG__)
endif()

# ##############################################################################
# 宏选项
# ##############################################################################
add_definitions(-DZMQ_BUILD_DRAFT_API)

# helper
# cbd_add_test takes in a source .cpp file and produces an executable
# with the same name of the source file in the common binary directory under the build directory.
function(cbd_add_test src module_name link_libs)
  # Obtain the name of the .cpp file without extension.
  get_filename_component(EXE_NAME ${src} NAME_WE)

  set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${CBD_OUTPUT_TEST_BINARY_DIR}")
  message(STATUS "EXE_NAME: ${EXE_NAME} src: ${src} module_name: ${module_name} link_libs: ${link_libs}")
  # Compile the source file to create an executable of the same name in the current binary directory.
  add_executable(${EXE_NAME} 
                 ${src}
  )
  target_link_libraries(${EXE_NAME}
                        PRIVATE
                        ${module_name} 
                        ${link_libs}
  )
endfunction(cbd_add_test)

# set target version
function(cbd_set_version proj major minor reversion soversion)
  set_target_properties(
    ${proj} PROPERTIES VERSION ${major}.${minor}.${reversion} SOVERSION
                                                              ${soversion})
endfunction(cbd_set_version)

# cbd_add_executable takes in a source .cpp file and produces a named
# executable. The executables inside the binary directory are built to building binary directory.
function(cbd_add_executable exe_name src link_libs)
  set(LIBS ${link_libs} ${ARGN})

  # Create a library from this module.
  add_executable(${exe_name} ${src})

  # Include all the target headers.
  target_include_directories(${exe_name} PUBLIC ${PROJECT_SOURCE_DIR}/include)

  # Include all the depending libraries.
  target_link_libraries(${exe_name} PRIVATE ${LIBS})
endfunction(cbd_add_executable)


## third_party ##
# gtest
if(CBD_TEST_ENABLE MATCHES "ON")
  enable_testing()
  add_subdirectory(third_party/googletest-1.15.0)
  include_directories(third_party/googletest-1.15.0/googletest/include) 
endif()

# erpc
set(ERPC_ROOT ${CMAKE_CURRENT_SOURCE_DIR}/third_party/erpc)
set(ERPC_DIR ${CMAKE_CURRENT_SOURCE_DIR}/third_party/erpc/erpc_c)
set(ERPCGEN_ROOT ${CMAKE_CURRENT_SOURCE_DIR}/third_party/erpcgen)

# 配置 erpc_c inclue 路径
set(ERPC_C_INC ${CMAKE_CURRENT_SOURCE_DIR}/third_party/erpc/erpc_c)
set(ERPC_GEN_INC ${CMAKE_CURRENT_SOURCE_DIR}/third_party/erpc/erpcgen)

# 配置 erpcgen 路径
set(ERPCGEN ${CMAKE_CURRENT_SOURCE_DIR}/third_party/erpc/bin/erpcgen)

## third_party arch ##
if(CBD_SYSTEM_NAME MATCHES "Linux")
  if(CBD_SYSTEM_PROCESSOR MATCHES "x86_64")
    set(CBD_THIRDPARTY_LIBRARY "${CBD_BASE_DIR}/platforms/arch/linux-x64")
  elseif(CBD_SYSTEM_PROCESSOR MATCHES "armv7")
    set(CBD_THIRDPARTY_LIBRARY "${CBD_BASE_DIR}/platform/linux-armv7")
  elseif(CBD_SYSTEM_PROCESSOR MATCHES "cortex-m")
    set(CBD_THIRDPARTY_LIBRARY "${CBD_BASE_DIR}/platforms/arch/comtex-m")
  elseif(CBD_SYSTEM_PROCESSOR MATCHES "risc-v")
    set(CBD_THIRDPARTY_LIBRARY "${CBD_BASE_DIR}/platforms/arch/risc-v")
  elseif(CBD_SYSTEM_PROCESSOR MATCHES "openwrt")
    set(CBD_THIRDPARTY_LIBRARY
        "${CBD_BASE_DIR}/platforms/arch/arm-openwrt-linux-gcc-6.4.1")
  else()
    message(FATAL_ERROR "Unsupported system process: " ${CBD_SYSTEM_PROCESSOR})
  endif()
  set(PROTOBUF_PROTOC_EXECUTABLE
      ${CBD_BASE_DIR}/platforms/arch/linux-x64/bins/protoc)
else()
  message(FATAL_ERROR "Unsupported system: " ${CBD_SYSTEM_NAME})
endif()

if(CBD_LIBRARY_TYPE MATCHES STATIC OR CBD_LIBRARY_STATIC_LINK_THIRDPARTY)
  include(third_party_linux)
else()
  include(third_party_linux_dynamic)
endif()

# version##
# ##############################################################################
# commons
# ##############################################################################
# commons/common
set(VERSION_COMMON_COMMON_MAJOR 1)
set(VERSION_COMMON_COMMON_MINOR 0)
set(VERSION_COMMON_COMMON_REVERSION 0)
set(VERSION_COMMON_COMMON_SOVERSION 1)
# commons/erpc
set(VERSION_COMMON_ERPCGEN_MAJOR 1)
set(VERSION_COMMON_ERPCGEN_MINOR 0)
set(VERSION_COMMON_ERPCGEN_REVERSION 0)
set(VERSION_COMMON_ERPCGEN_SOVERSION 1)
# commons/log
set(VERSION_COMMON_LOG_MAJOR 1)
set(VERSION_COMMON_LOG_MINOR 0)
set(VERSION_COMMON_LOG_REVERSION 0)
set(VERSION_COMMON_LOG_SOVERSION 1)

# ##############################################################################
# components
# ##############################################################################
# components/driver
set(VERSION_COMPONENT_DRIVER_MAJOR 1)
set(VERSION_COMPONENT_DRIVER_MINOR 0)
set(VERSION_COMPONENT_DRIVER_REVERSION 0)
set(VERSION_COMPONENT_DRIVER_SOVERSION 1)
# components/driver/canopen
set(VERSION_COMPONENT_DRIVER_CANOPEN_MAJOR 1)
set(VERSION_COMPONENT_DRIVER_CANOPEN_MINOR 0)
set(VERSION_COMPONENT_DRIVER_CANOPEN_REVERSION 0)
set(VERSION_COMPONENT_DRIVER_CANOPEN_SOVERSION 1)

# components/hardware
set(VERSION_COMPONENT_HARDWARE_MAJOR 1)
set(VERSION_COMPONENT_HARDWARE_MINOR 0)
set(VERSION_COMPONENT_HARDWARE_REVERSION 0)
set(VERSION_COMPONENT_HARDWARE_SOVERSION 1)
# components/network
set(VERSION_COMPONENT_NETWORK_MAJOR 1)
set(VERSION_COMPONENT_NETWORK_MINOR 0)
set(VERSION_COMPONENT_NETWORK_REVERSION 0)
set(VERSION_COMPONENT_NETWORK_SOVERSION 1)
# components/parameter
set(VERSION_COMPONENT_PARAMETER_MAJOR 1)
set(VERSION_COMPONENT_PARAMETER_MINOR 0)
set(VERSION_COMPONENT_PARAMETER_REVERSION 0)
set(VERSION_COMPONENT_PARAMETER_SOVERSION 1)

# ##############################################################################
# apps
# ##############################################################################
# apps/fdm
set(VERSION_APP_FDM_MAJOR 1)
set(VERSION_APP_FDM_MINOR 0)
set(VERSION_APP_FDM_REVERSION 0)
set(VERSION_APP_FDM_SOVERSION 1)

# ##############################################################################
# nodes
# ##############################################################################
# nodes/diagnose
set(VERSION_NODE_DIAGNOSE_MAJOR 1)
set(VERSION_NODE_DIAGNOSE_MINOR 0)
set(VERSION_NODE_DIAGNOSE_REVERSION 0)
set(VERSION_NODE_DIAGNOSE_SOVERSION 1)
# nodes/perception
set(VERSION_NODE_PERCEPTION_MAJOR 1)
set(VERSION_NODE_PERCEPTION_MINOR 0)
set(VERSION_NODE_PERCEPTION_REVERSION 0)
set(VERSION_NODE_PERCEPTION_SOVERSION 1)
# nodes/motion
set(VERSION_NODE_MOTION_MAJOR 1)
set(VERSION_NODE_MOTION_MINOR 0)
set(VERSION_NODE_MOTION_REVERSION 0)
set(VERSION_NODE_MOTION_SOVERSION 1)
# nodes/printer
set(VERSION_NODE_PRINTER_MAJOR 1)
set(VERSION_NODE_PRINTER_MINOR 0)
set(VERSION_NODE_PRINTER_REVERSION 0)
set(VERSION_NODE_PRINTER_SOVERSION 1)
# nodes/toolstudio
set(VERSION_NODE_TOOLSTUDIO_MAJOR 1)
set(VERSION_NODE_TOOLSTUDIO_MINOR 0)
set(VERSION_NODE_TOOLSTUDIO_REVERSION 0)
set(VERSION_NODE_TOOLSTUDIO_SOVERSION 1)
# nodes/ui
set(VERSION_NODE_UI_MAJOR 1)
set(VERSION_NODE_UI_MINOR 0)
set(VERSION_NODE_UI_REVERSION 0)
set(VERSION_NODE_UI_SOVERSION 1)
# nodes/communication
set(VERSION_NODE_COMMUNICATION_MAJOR 1)
set(VERSION_NODE_COMMUNICATION_MINOR 0)
set(VERSION_NODE_COMMUNICATION_REVERSION 0)
set(VERSION_NODE_COMMUNICATION_SOVERSION 1)

# add build library path
add_subdirectory(commons)
add_subdirectory(components)
add_subdirectory(nodes)

# add build binary path
add_subdirectory(apps)

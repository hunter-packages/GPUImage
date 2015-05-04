cmake_minimum_required(VERSION 3.0)

include("cmake/HunterGate.cmake")
HunterGate(
    URL "https://github.com/ruslo/hunter/archive/v0.8.4.tar.gz"
    SHA1 "e07a124192b0a47b0b60ade40fa873a42ec27822"
)

project(GPUImage)
option(GPUIMAGE_BUILD_EXAMPLES "Build examples" ON)

hunter_add_package(Sugar)
include("${SUGAR_ROOT}/cmake/Sugar")
include(sugar_include)

sugar_include("./framework") # GPUIMAGE_SOURCES

string(COMPARE EQUAL "${CMAKE_OSX_SYSROOT}" "iphoneos" is_ios)
if(is_ios)
  set(platform "iOS")
else()
  set(platform "Mac")
endif()

add_library(gpuimage ${GPUIMAGE_SOURCES})
target_include_directories(
    gpuimage
    PUBLIC
    "$<BUILD_INTERFACE:${CMAKE_CURRENT_LIST_DIR}/framework/Source/${platform}>"
    "$<BUILD_INTERFACE:${CMAKE_CURRENT_LIST_DIR}/framework/Source>"
    "$<INSTALL_INTERFACE:include>"
)

set_target_properties(
    gpuimage
    PROPERTIES
    XCODE_ATTRIBUTE_CLANG_ENABLE_OBJC_ARC YES
)

if(is_ios)
  target_link_libraries(
      gpuimage
      "-framework CoreMedia"
      "-framework CoreVideo"
      "-framework OpenGLES"
      "-framework QuartzCore"
      "-framework AVFoundation"
      "-framework UIKit"
      "-framework Foundation"
  )
else()
  target_link_libraries(
      gpuimage
      "-framework Cocoa"
      "-framework OpenGL"
      "-framework QuartzCore"
      "-framework CoreMedia"
      "-framework AVFoundation"
      "-framework AppKit"
      "-framework CoreData"
      "-framework Foundation"
  )
  target_link_libraries(gpuimage "-ObjC")
endif()

if(GPUIMAGE_BUILD_EXAMPLES)
  if(is_ios)
    add_subdirectory("./examples/iOS")
  else()
    add_subdirectory("./examples/Mac")
  endif()
endif()

install(FILES GPUImageConfig.cmake DESTINATION "lib/cmake/GPUImage")
install(TARGETS gpuimage DESTINATION "lib" EXPORT GPUImageTargets)
install(
    EXPORT GPUImageTargets NAMESPACE GPUImage:: DESTINATION "lib/cmake/GPUImage"
)

set(headers "")
foreach(x ${GPUIMAGE_SOURCES})
  string(REGEX MATCH ".*\\.h$" is_header "${x}")
  if(is_header)
    list(APPEND headers "${x}")
  endif()
endforeach()

install(FILES ${headers} DESTINATION "include/GPUImage")

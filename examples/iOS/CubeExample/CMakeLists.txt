cmake_minimum_required(VERSION 3.0)

include("cmake/HunterGate.cmake")
HunterGate(
    URL "https://github.com/ruslo/hunter/archive/v0.8.5.tar.gz"
    SHA1 "682a963d3e0c7f59eca36ed4b3faee0ab4010788"
)

project(GPUImage)

hunter_add_package(Sugar)
include("${SUGAR_ROOT}/cmake/Sugar")
include(sugar_include)

sugar_include("./")

add_executable(
    CubeExample
    ${CUBEEXAMPLE_SOURCES}
    ${CUBEEXAMPLE_RESOURCES}
    ${CUBEEXAMPLE_SHADERS}
)

set_source_files_properties(
    ${CUBEEXAMPLE_SHADERS}
    PROPERTIES
    MACOSX_PACKAGE_LOCATION
    .
)

set_target_properties(
    CubeExample
    PROPERTIES
    MACOSX_BUNDLE YES
    MACOSX_BUNDLE_INFO_PLIST "${CUBEEXAMPLE_PLIST}"
    XCODE_ATTRIBUTE_CODE_SIGN_IDENTITY "iPhone Developer"
    XCODE_ATTRIBUTE_TARGETED_DEVICE_FAMILY "1,2"
    XCODE_ATTRIBUTE_CLANG_ENABLE_OBJC_ARC NO
    XCODE_ATTRIBUTE_INSTALL_PATH "${CMAKE_BINARY_DIR}/ProductRelease"
    XCODE_ATTRIBUTE_COMBINE_HIDPI_IMAGES "NO"
    RESOURCE "${CUBEEXAMPLE_RESOURCES};${CUBEEXAMPLE_SHADERS}"
)

set_target_properties(
    CubeExample
    PROPERTIES
    XCODE_ATTRIBUTE_PRODUCT_NAME
    "CubeExample"
    XCODE_ATTRIBUTE_BUNDLE_IDENTIFIER
    "com.example.CubeExample"
)

target_link_libraries(
    CubeExample
    PRIVATE
    "-framework CoreGraphics"
    "-framework Foundation"
    "-framework UIKit"
)

if(TARGET gpuimage)
  add_library(GPUImage::gpuimage gpuimage)
else()
  hunter_add_package(GPUImage)
  find_package(GPUImage CONFIG REQUIRED)
  target_include_directories(
      CubeExample PRIVATE "${GPUImage_DIR}/../../../include/GPUImage"
  )
endif()

target_link_libraries(CubeExample PRIVATE GPUImage::gpuimage)

target_include_directories(CubeExample PRIVATE "./Classes")

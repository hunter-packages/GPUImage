cmake_minimum_required(VERSION 3.0)

include("cmake/HunterGate.cmake")
HunterGate(
    URL "https://github.com/ruslo/hunter/archive/v0.19.234.tar.gz"
    SHA1 "3deec1041bd01c91e78269522b901fbab3a765e5"
)

project(GPUImage VERSION 0.1.6)
option(GPUIMAGE_BUILD_EXAMPLES "Build examples" OFF)

hunter_add_package(sugar)
find_package(sugar CONFIG REQUIRED)

sugar_include("./framework") # GPUIMAGE_SOURCES

if(IOS)
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

if(IOS)
  find_package(coremedia REQUIRED)
  find_package(corevideo REQUIRED)
  find_package(coregraphics REQUIRED)
  find_package(opengles REQUIRED)
  find_package(quartzcore REQUIRED)
  find_package(avfoundation REQUIRED)
  find_package(uikit REQUIRED)
  find_package(foundation REQUIRED)

  target_link_libraries(
      gpuimage
      PUBLIC
      coremedia::coremedia
      corevideo::corevideo
      coregraphics::coregraphics
      opengles::opengles
      quartzcore::quartzcore
      avfoundation::avfoundation
      uikit::uikit
      foundation::foundation
  )
else()
  find_package(OpenGL REQUIRED)

  find_package(foundation REQUIRED)
  find_package(appkit REQUIRED)
  find_package(coredata REQUIRED)
  find_package(quartzcore REQUIRED)
  find_package(coremedia REQUIRED)
  find_package(avfoundation REQUIRED)
  find_package(appkit REQUIRED)
  find_package(coredata REQUIRED)
  find_package(foundation REQUIRED)

  target_link_libraries(
      gpuimage
      PUBLIC
      OpenGL::GL
      foundation::foundation
      appkit::appkit
      coredata::coredata
      quartzcore::quartzcore
      coremedia::coremedia
      avfoundation::avfoundation
      appkit::appkit
      coredata::coredata
      foundation::foundation
  )
endif()
target_link_libraries(gpuimage PRIVATE "-ObjC")

if(GPUIMAGE_BUILD_EXAMPLES)
  if(IOS)
    add_subdirectory("./examples/iOS")
  else()
    add_subdirectory("./examples/Mac")
  endif()
endif()

# Installation (https://github.com/forexample/package-example) {

# Layout. This works for all platforms:
#   * <prefix>/lib/cmake/<PROJECT-NAME>
#   * <prefix>/lib/
#   * <prefix>/include/
set(config_install_dir "lib/cmake/${PROJECT_NAME}")
set(include_install_dir "include")

set(generated_dir "${CMAKE_CURRENT_BINARY_DIR}/generated")

# Configuration
set(version_config "${generated_dir}/${PROJECT_NAME}ConfigVersion.cmake")
set(project_config "${generated_dir}/${PROJECT_NAME}Config.cmake")
set(TARGETS_EXPORT_NAME "${PROJECT_NAME}Targets")
set(namespace "${PROJECT_NAME}::")

# Include module with fuction 'write_basic_package_version_file'
include(CMakePackageConfigHelpers)

# Configure '<PROJECT-NAME>ConfigVersion.cmake'
# Use:
#   * PROJECT_VERSION
write_basic_package_version_file(
    "${version_config}" COMPATIBILITY SameMajorVersion
)

# Configure '<PROJECT-NAME>Config.cmake'
# Use variables:
#   * TARGETS_EXPORT_NAME
#   * PROJECT_NAME
configure_package_config_file(
    "cmake/Config.cmake.in"
    "${project_config}"
    INSTALL_DESTINATION "${config_install_dir}"
)

# Targets:
#   * <prefix>/lib/lib${PROJECT_NAME}.a
#   * header location after install: <prefix>/include/GPUImage/Bar.hpp
#   * headers can be included by C++ code `#include <GPUImage/Bar.hpp>`
install(
    TARGETS gpuimage
    EXPORT "${TARGETS_EXPORT_NAME}"
    LIBRARY DESTINATION "lib"
    ARCHIVE DESTINATION "lib"
    RUNTIME DESTINATION "bin"
    INCLUDES DESTINATION "${include_install_dir}"
)

# Headers: <prefix>/include/GPUImage/Bar.hpp
set(headers "")
foreach(x ${GPUIMAGE_SOURCES})
  string(REGEX MATCH ".*\\.h$" is_header "${x}")
  if(is_header)
    list(APPEND headers "${x}")
  endif()
endforeach()

install(FILES ${headers} DESTINATION "include/GPUImage")

# Config
#   * <prefix>/lib/cmake/GPUImage/GPUImageConfig.cmake
#   * <prefix>/lib/cmake/GPUImage/GPUImageConfigVersion.cmake
install(
    FILES "${project_config}" "${version_config}"
    DESTINATION "${config_install_dir}"
)

# Config
#   * <prefix>/lib/cmake/GPUImage/GPUImageTargets.cmake
install(
    EXPORT "${TARGETS_EXPORT_NAME}"
    NAMESPACE "${namespace}"
    DESTINATION "${config_install_dir}"
)

# }

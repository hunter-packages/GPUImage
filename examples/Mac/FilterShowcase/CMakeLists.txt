cmake_minimum_required(VERSION 3.0)

include("cmake/HunterGate.cmake")
HunterGate(
    URL "https://github.com/ruslo/hunter/archive/v0.19.234.tar.gz"
    SHA1 "3deec1041bd01c91e78269522b901fbab3a765e5"
)

project(GPUImage)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

hunter_add_package(sugar)
find_package(sugar CONFIG REQUIRED)
include(sugar_include)

sugar_include("./")

add_executable(
    FilterShowcase
    MACOSX_BUNDLE
    ${FILTERSHOWCASE_SOURCES}
    ${FILTERSHOWCASE_RESOURCES}
)

set_source_files_properties(
    ${FILTERSHOWCASE_RESOURCES}
    PROPERTIES
    MACOSX_PACKAGE_LOCATION
    Resources
)

set_target_properties(
    FilterShowcase
    PROPERTIES
    MACOSX_BUNDLE_INFO_PLIST
    ${FILTERSHOWCASE_PLIST}
)

if(TARGET gpuimage)
  set(temp_include "${CMAKE_CURRENT_BINARY_DIR}/A")
  file(MAKE_DIRECTORY "${temp_include}")
  execute_process(
      COMMAND
      "${CMAKE_COMMAND}"
      -E
      create_symlink
      "${CMAKE_CURRENT_LIST_DIR}/../../../framework/Source/Mac"
      "${CMAKE_CURRENT_BINARY_DIR}/GPUImage"
  )
  execute_process(
      COMMAND
      "${CMAKE_COMMAND}"
      -E
      create_symlink
      "${CMAKE_CURRENT_LIST_DIR}/../../../framework/Source/"
      "${temp_include}/GPUImage"
  )
  target_link_libraries(FilterShowcase PRIVATE gpuimage)
  target_include_directories(FilterShowcase PRIVATE "${temp_include}")
else()
  hunter_add_package(GPUImage)
  find_package(GPUImage CONFIG REQUIRED)
  target_link_libraries(FilterShowcase PRIVATE GPUImage::gpuimage)
endif()

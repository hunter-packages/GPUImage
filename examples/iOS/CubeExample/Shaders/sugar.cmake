# This file generated automatically by:
#   generate_sugar_files.py
# see wiki for more info:
#   https://github.com/ruslo/sugar/wiki/Collecting-sources

if(DEFINED CUBEEXAMPLE_SHADERS_SUGAR_CMAKE_)
  return()
else()
  set(CUBEEXAMPLE_SHADERS_SUGAR_CMAKE_ 1)
endif()

include(sugar_files)

sugar_files(
    CUBEEXAMPLE_SHADERS
    Shader.fsh
    Shader.vsh
)

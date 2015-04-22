# This file generated automatically by:
#   generate_sugar_files.py
# see wiki for more info:
#   https://github.com/ruslo/sugar/wiki/Collecting-sources

if(DEFINED CUBEEXAMPLE_CLASSES_SUGAR_CMAKE_)
  return()
else()
  set(CUBEEXAMPLE_CLASSES_SUGAR_CMAKE_ 1)
endif()

include(sugar_files)

sugar_files(
    CUBEEXAMPLE_SOURCES
    CubeExampleAppDelegate.h
    CubeExampleAppDelegate.m
    DisplayViewController.h
    DisplayViewController.m
    ES2Renderer.h
    ES2Renderer.m
    ESRenderer.h
)

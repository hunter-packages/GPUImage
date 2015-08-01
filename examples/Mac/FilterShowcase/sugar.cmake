# This file generated automatically by:
#   generate_sugar_files.py
# see wiki for more info:
#   https://github.com/ruslo/sugar/wiki/Collecting-sources

if(DEFINED FILTERSHOWCASE_SUGAR_CMAKE_)
  return()
else()
  set(FILTERSHOWCASE_SUGAR_CMAKE_ 1)
endif()

include(sugar_files)
include(sugar_include)

sugar_include(FilterShowcase)

sugar_files(
    FILTERSHOWCASE_SOURCES
    SLSFilterShowcaseWindowController.h
    SLSFilterShowcaseWindowController.m
)

sugar_files(
    FILTERSHOWCASE_RESOURCES
    FilterShowcase/en.lproj/MainMenu.xib
    SLSFilterShowcaseWindowController.xib
)

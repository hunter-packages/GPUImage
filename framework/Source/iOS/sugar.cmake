# This file generated automatically by:
#   generate_sugar_files.py
# see wiki for more info:
#   https://github.com/ruslo/sugar/wiki/Collecting-sources

if(DEFINED GPUIMAGE_SOURCE_IOS_SUGAR_CMAKE_)
  return()
else()
  set(GPUIMAGE_SOURCE_IOS_SUGAR_CMAKE_ 1)
endif()

include(sugar_files)
include(sugar_include)

sugar_include(Framework)

sugar_files(
    GPUIMAGE_SOURCES
    GPUImageContext.h
    GPUImageContext.m
    GPUImageMovieWriter.h
    GPUImageMovieWriter.m
    GPUImagePicture+TextureSubimage.h
    GPUImagePicture+TextureSubimage.m
    GPUImagePicture.h
    GPUImagePicture.m
    GPUImageView.h
    GPUImageView.m
)

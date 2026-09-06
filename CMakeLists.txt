cmake_minimum_required(VERSION 3.24)

project(DtBlkFxForMacintosh VERSION 0.1.0 LANGUAGES C CXX)

option(DTBLKFX_BUILD_PLUGIN "Build the ported plugin targets" OFF)
option(DTBLKFX_ENABLE_FFTW "Locate and expose single-precision FFTW3f for plugin targets" OFF)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

if(APPLE AND DEFINED CMAKE_OSX_ARCHITECTURES)
  if(NOT CMAKE_OSX_ARCHITECTURES MATCHES "(^|;)arm64(;|$)")
    message(FATAL_ERROR
      "DtBlkFx for Macintosh requires an arm64 build architecture; got '${CMAKE_OSX_ARCHITECTURES}'.")
  endif()
endif()

if(DTBLKFX_ENABLE_FFTW)
  find_package(PkgConfig QUIET)
  if(PkgConfig_FOUND)
    pkg_check_modules(FFTW3F IMPORTED_TARGET fftw3f)
  endif()

  if(NOT TARGET PkgConfig::FFTW3F)
    find_path(FFTW3F_INCLUDE_DIR NAMES fftw3.h)
    find_library(FFTW3F_LIBRARY NAMES fftw3f)
    if(NOT FFTW3F_INCLUDE_DIR OR NOT FFTW3F_LIBRARY)
      message(FATAL_ERROR
        "FFTW3f was requested but not found. Install an arm64 FFTW3 development package "
        "and set FFTW3F_INCLUDE_DIR/FFTW3F_LIBRARY if it is outside the default search path.")
    endif()
    add_library(DtblkFx::FFTW3F UNKNOWN IMPORTED)
    set_target_properties(DtblkFx::FFTW3F PROPERTIES
      IMPORTED_LOCATION "${FFTW3F_LIBRARY}"
      INTERFACE_INCLUDE_DIRECTORIES "${FFTW3F_INCLUDE_DIR}")
  else()
    add_library(DtblkFx::FFTW3F ALIAS PkgConfig::FFTW3F)
  endif()
  message(STATUS "FFTW3f support: enabled (single-precision ABI)")
else()
  message(STATUS "FFTW3f support: disabled (enable after upstream dependency verification)")
endif()

if(DTBLKFX_BUILD_PLUGIN)
  message(FATAL_ERROR
    "Plugin sources are not present yet. Keep DTBLKFX_BUILD_PLUGIN=OFF during the scaffolding phase.")
endif()

message(STATUS "DtBlkFx scaffolding configured for ${CMAKE_SYSTEM_NAME} ${CMAKE_SYSTEM_PROCESSOR}")

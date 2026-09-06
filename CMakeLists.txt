cmake_minimum_required(VERSION 3.24)

project(DtBlkFxForMacintosh VERSION 0.1.0 LANGUAGES C CXX)

option(DTBLKFX_BUILD_PLUGIN "Build the ported plugin targets" OFF)
option(DTBLKFX_ENABLE_FFTW "Locate and expose FFTW3 for plugin targets" OFF)

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
    pkg_check_modules(FFTW3 IMPORTED_TARGET fftw3)
  endif()

  if(NOT TARGET PkgConfig::FFTW3)
    find_path(FFTW3_INCLUDE_DIR NAMES fftw3.h)
    find_library(FFTW3_LIBRARY NAMES fftw3)
    if(NOT FFTW3_INCLUDE_DIR OR NOT FFTW3_LIBRARY)
      message(FATAL_ERROR
        "FFTW3 was requested but not found. Install an arm64 FFTW3 development package "
        "and set FFTW3_INCLUDE_DIR/FFTW3_LIBRARY if it is outside the default search path.")
    endif()
    add_library(DtblkFx::FFTW3 UNKNOWN IMPORTED)
    set_target_properties(DtblkFx::FFTW3 PROPERTIES
      IMPORTED_LOCATION "${FFTW3_LIBRARY}"
      INTERFACE_INCLUDE_DIRECTORIES "${FFTW3_INCLUDE_DIR}")
  else()
    add_library(DtblkFx::FFTW3 ALIAS PkgConfig::FFTW3)
  endif()
  message(STATUS "FFTW3 support: enabled")
else()
  message(STATUS "FFTW3 support: disabled (enable after upstream dependency verification)")
endif()

if(DTBLKFX_BUILD_PLUGIN)
  message(FATAL_ERROR
    "Plugin sources are not present yet. Keep DTBLKFX_BUILD_PLUGIN=OFF during the scaffolding phase.")
endif()

message(STATUS "DtBlkFx scaffolding configured for ${CMAKE_SYSTEM_NAME} ${CMAKE_SYSTEM_PROCESSOR}")

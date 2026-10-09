cmake_minimum_required(VERSION 3.21)
option(FORMAT_VALIDATION_ONLY "Configure formatting without compilers or native dependencies" OFF)
if(FORMAT_VALIDATION_ONLY)
    project(FormatValidation LANGUAGES NONE)
    include(cmake/FormatValidation.cmake)
    return()
endif()
include(cmake/Metamod.cmake)
project(fallguys LANGUAGES C CXX)
if(NOT CMAKE_CONFIGURATION_TYPES AND NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Release CACHE STRING "Build configuration" FORCE)
endif()
include("${METAMOD_SOURCE_PATH}/cmake/SDK.cmake")
include(cmake/ASExt.cmake)

add_library(fallguys SHARED
    src/dllapi.cpp
    src/engine_api.cpp
    src/engine_hook.cpp
    src/fallguys.cpp
    src/h_export.cpp
    src/meta_api.cpp
    src/physics.cpp
    src/server_hook.cpp
    src/soundengine.cpp
)
mmfg_configure_target(fallguys)
target_link_libraries(fallguys PRIVATE ASExt::SDK)
if(WIN32)
    target_sources(fallguys PRIVATE src/dllmain.cpp)
    target_compile_definitions(fallguys PRIVATE FALLGUYS_EXPORTS)
endif()
mmfg_capstone_headers()
mmfg_bullet_library()
target_include_directories(fallguys PRIVATE thirdparty/fmod)
target_link_libraries(fallguys PRIVATE Capstone::Headers Bullet::Libraries)

include(cmake/FormatValidation.cmake)

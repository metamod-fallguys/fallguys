include(FetchContent)

# FallGuys is the only consumer of Bullet, so the fork is owned as a nested
# submodule of this component instead of a shared aggregate dependency.
if(NOT DEFINED BULLET3_SOURCE_PATH)
    set(BULLET3_SOURCE_PATH "$ENV{BULLET3_SOURCE_PATH}" CACHE PATH "Local bullet3 clone; empty reuses the nested submodule or fetches the pinned revision")
endif()
if(NOT BULLET3_SOURCE_PATH AND EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/thirdparty/bullet3_fork/CMakeLists.txt")
    set(BULLET3_SOURCE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/thirdparty/bullet3_fork")
endif()
if(BULLET3_SOURCE_PATH)
    get_filename_component(BULLET3_SOURCE_PATH "${BULLET3_SOURCE_PATH}" ABSOLUTE BASE_DIR "${CMAKE_CURRENT_SOURCE_DIR}")
else()
    FetchContent_Declare(mmfg_bullet3
        GIT_REPOSITORY https://github.com/hzqst/bullet3.git
        GIT_TAG 1217225ca0ad39a7982513d47ca7364ed16f0043
        GIT_SUBMODULES "" GIT_SUBMODULES_RECURSE FALSE SOURCE_SUBDIR mmfg-source-only)
    FetchContent_MakeAvailable(mmfg_bullet3)
    set(BULLET3_SOURCE_PATH "${mmfg_bullet3_SOURCE_DIR}")
endif()
foreach(file CMakeLists.txt src/btBulletDynamicsCommon.h)
    if(NOT EXISTS "${BULLET3_SOURCE_PATH}/${file}")
        message(FATAL_ERROR "BULLET3_SOURCE_PATH is missing ${file}: ${BULLET3_SOURCE_PATH}")
    endif()
endforeach()
message(STATUS "BULLET3_SOURCE_PATH: ${BULLET3_SOURCE_PATH}")

function(mmfg_bullet_library)
    if(TARGET BulletDynamics)
        return()
    endif()
    set(BUILD_SHARED_LIBS OFF)
    set(CMAKE_POLICY_DEFAULT_CMP0077 NEW)
    set(BUILD_BULLET3 ON)
    foreach(option BULLET2_DEMOS BULLET_ROBOTICS_EXTRA BULLET_ROBOTICS_GUI_EXTRA CLSOCKET
        CONVEX_DECOMPOSITION_EXTRA CPU_DEMO NET EXTRAS GIMPACTUTILS_EXTRA HACD_EXTRA
        INVERSE_DYNAMIC_EXTRA OBJ2SDF_EXTRA OPENGL3_DEMOS PYBULLET SERIALIZE_EXTRA UNIT_TESTS)
        set(BUILD_${option} OFF)
    endforeach()
    foreach(option MSVC_SSE2 MSVC_SSE MSVC_AVX MSVC_AVX2 GLUT GRAPHICAL_BENCHMARK)
        set(USE_${option} OFF)
    endforeach()
    set(B3_USE_CLEW OFF)
    set(INSTALL_LIBS OFF)
    set(CMAKE_POSITION_INDEPENDENT_CODE ON)
    add_subdirectory("${BULLET3_SOURCE_PATH}" "${CMAKE_BINARY_DIR}/vendor/bullet" EXCLUDE_FROM_ALL)
    add_library(mmfg_bullet INTERFACE)
    add_library(Bullet::Libraries ALIAS mmfg_bullet)
    target_include_directories(mmfg_bullet INTERFACE "${BULLET3_SOURCE_PATH}/src")
    target_link_libraries(mmfg_bullet INTERFACE Bullet3Dynamics Bullet3Collision Bullet3Common
        Bullet3Geometry BulletSoftBody BulletDynamics BulletCollision LinearMath)
endfunction()

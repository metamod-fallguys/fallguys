include("${CMAKE_CURRENT_LIST_DIR}/Revisions.cmake")
mmfg_source(asext ASEXT_SOURCE_PATH https://github.com/metamod-fallguys/asext.git
    "${MMFG_ASEXT_REVISION}" "include/asext_api.h;cmake/SDK.cmake" asext_source)
include("${asext_source}/cmake/SDK.cmake")

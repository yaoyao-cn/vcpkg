if(NOT _VCPKG_OHOS_TOOLCHAIN)
    set(_VCPKG_OHOS_TOOLCHAIN 1)

set(OHOS_STL c++_shared CACHE STRING "")
set(CMAKE_SYSTEM_NAME OHOS CACHE STRING "")
#VCPKG_KEEP_ENV_VARS <-------Can help u add env into vcpkg
#execute_process(COMMAND ${CMAKE_COMMAND} -E environment)#<-------Show env of vcpkg
if(NOT EXISTS "$ENV{OHOS_NDK_HOME}/build/cmake/ohos.toolchain.cmake")
    message(FATAL_ERROR "Could not find OHOS ndk. Searched at ${OHOS_NDK_HOME}")
endif()

include("$ENV{OHOS_NDK_HOME}/build/cmake/ohos.toolchain.cmake")
endif()

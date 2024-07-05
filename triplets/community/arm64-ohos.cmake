
set(VCPKG_TARGET_ARCHITECTURE arm64)

set(VCPKG_CRT_LINKAGE static)
set(VCPKG_LIBRARY_LINKAGE static)
set(VCPKG_CMAKE_SYSTEM_NAME OHOS)

set(VCPKG_CHAINLOAD_TOOLCHAIN_FILE "${CMAKE_CURRENT_LIST_DIR}/../../scripts/toolchains/ohos.cmake")

#https://learn.microsoft.com/en-us/vcpkg/users/triplets#vcpkg_dep_info_override_vars
#VCPKG_DEP_INFO_OVERRIDE_VARS
#Note
#This section covers an experimental feature of vcpkg which may change or be removed at any time.
#Replaces the default computed list of triplet "Supports" terms.
#This option (if set) will override the default set of terms used for Platform Expression evaluation.
#See the "supports" manifest file field documentation for more details.
#Note
#This list is extracted via the vcpkg_get_dep_info helper function.
set(VCPKG_DEP_INFO_OVERRIDE_VARS ohos)
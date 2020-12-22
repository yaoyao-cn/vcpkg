include(vcpkg_common_functions)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO yaoyao-cn/md5
    REF aae5268c14e0de8f22451ed58d0cfda961e1e65f
    HEAD_REF master
    SHA512 135b4e24697035528aab42205e0d7934aff96fc57b942cd5aeb039bfecc9e755483a6a3b3fab5209bcc3966aecf9c5cd65ae410beb11a9796fd5e4dfc3baa406
)

file(COPY 
    ${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt 
    ${CMAKE_CURRENT_LIST_DIR}/md5-config.in.cmake
    DESTINATION ${SOURCE_PATH}
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
)

vcpkg_install_cmake()

vcpkg_fixup_cmake_targets(CONFIG_PATH share/unofficial-${PORT} TARGET_PATH share/unofficial-${PORT})

file(REMOVE_RECURSE 
    "${CURRENT_PACKAGES_DIR}/debug/include"
    "${CURRENT_PACKAGES_DIR}/debug/share"
)

vcpkg_copy_pdbs()
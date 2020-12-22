include(vcpkg_common_functions)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO yaoyao-cn/md5
    REF 314d64352ce58a9b4765bfedc810671d831a4950
    HEAD_REF master
    SHA512 666a7c15588f8794ff8857e030fc6fd34592f5fab3edfbe5f370ca4be99cf3eae6283439bba12c8fd09c525eb1d5bd7b0411fd7a9efeb27f65600deabb542668
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
)

vcpkg_install_cmake()

vcpkg_fixup_cmake_targets(CONFIG_PATH share/${PORT} TARGET_PATH share/${PORT})

file(REMOVE_RECURSE 
    "${CURRENT_PACKAGES_DIR}/debug/include"
    "${CURRENT_PACKAGES_DIR}/debug/share"
)

vcpkg_copy_pdbs()
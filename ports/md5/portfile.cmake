include(vcpkg_common_functions)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO yaoyao-cn/md5
    REF aae5268c14e0de8f22451ed58d0cfda961e1e65f
    HEAD_REF master
    SHA512 135b4e24697035528aab42205e0d7934aff96fc57b942cd5aeb039bfecc9e755483a6a3b3fab5209bcc3966aecf9c5cd65ae410beb11a9796fd5e4dfc3baa406
)

file(COPY ${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt DESTINATION ${SOURCE_PATH})

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
)

vcpkg_install_cmake()

file(COPY ${SOURCE_PATH}/md5.h DESTINATION ${CURRENT_PACKAGES_DIR}/include)

# Handle copyright
file(COPY ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/md5)
file(RENAME ${CURRENT_PACKAGES_DIR}/share/md5/LICENSE ${CURRENT_PACKAGES_DIR}/share/md5/copyright)

vcpkg_copy_pdbs()
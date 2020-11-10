<<<<<<< HEAD
include(vcpkg_common_functions)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO yaoyao-cn/poly2tri
    REF 88de49021b6d9bef6faa1bc94ceb3fbd85c3c204
    HEAD_REF master
    SHA512 fa256bcf923ad59f42205edf5a7e07cac6cbd9a37cefb9a0961a2e06aea7fa8ffd09d4e26154c0028601c12804483842cb935d9f602385f5f203c9628382c4fb
)

file(COPY ${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt DESTINATION ${SOURCE_PATH})

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
)

vcpkg_install_cmake()

file(COPY ${SOURCE_PATH}/poly2tri/poly2tri.h DESTINATION ${CURRENT_PACKAGES_DIR}/include/poly2tri)

file(COPY ${SOURCE_PATH}/poly2tri/sweep/sweep.h 
    ${SOURCE_PATH}/poly2tri/sweep/cdt.h
    ${SOURCE_PATH}/poly2tri/sweep/advancing_front.h
    ${SOURCE_PATH}/poly2tri/sweep/sweep_context.h
    DESTINATION ${CURRENT_PACKAGES_DIR}/include/poly2tri/sweep)

file(COPY ${SOURCE_PATH}/poly2tri/common/shapes.h 
    ${SOURCE_PATH}/poly2tri/common/utils.h
    DESTINATION ${CURRENT_PACKAGES_DIR}/include/poly2tri/common)

# Handle copyright
file(COPY ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/poly2tri)
file(RENAME ${CURRENT_PACKAGES_DIR}/share/poly2tri/LICENSE ${CURRENT_PACKAGES_DIR}/share/poly2tri/copyright)

vcpkg_copy_pdbs()
=======
vcpkg_fail_port_install(ON_TARGET "uwp")

vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO greenm01/poly2tri
    REF 88de49021b6d9bef6faa1bc94ceb3fbd85c3c204
    SHA512 fa256bcf923ad59f42205edf5a7e07cac6cbd9a37cefb9a0961a2e06aea7fa8ffd09d4e26154c0028601c12804483842cb935d9f602385f5f203c9628382c4fb
    HEAD_REF master
)

file(COPY ${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt DESTINATION ${SOURCE_PATH})

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
)

vcpkg_install_cmake()
vcpkg_fixup_cmake_targets()

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/share)

file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)
>>>>>>> upstream/master

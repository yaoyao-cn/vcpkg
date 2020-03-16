# libgit2 uses winapi functions not available in WindowsStore
vcpkg_fail_port_install(ON_TARGET "uwp")

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO libgit2/libgit2
    REF v0.99.0
    SHA512 e38e18da0e6ed1e5c8198c9eb2c362b21da2d0b9c8bc23309d2f70183549f4b9f23a6db8ce5f1f0f24b373e6427039c2a845b62dd74f91b02cfe8954f961a91b
    HEAD_REF master
)

string(COMPARE EQUAL "${VCPKG_CRT_LINKAGE}" "static" STATIC_CRT)

if ("pcre" IN_LIST FEATURES)
    set(REGEX_BACKEND pcre)
elseif ("pcre2" IN_LIST FEATURES)
    set(REGEX_BACKEND pcre2)
else()
    set(REGEX_BACKEND builtin)
endif()

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS
        -DBUILD_CLAR=OFF
        -DREGEX_BACKEND=${REGEX_BACKEND}
        -DSTATIC_CRT=${STATIC_CRT}
)

vcpkg_install_cmake()

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)

file(INSTALL ${SOURCE_PATH}/COPYING DESTINATION ${CURRENT_PACKAGES_DIR}/share/libgit2 RENAME copyright)

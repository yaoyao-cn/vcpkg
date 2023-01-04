# Automatically generated by scripts/boost/generate-ports.ps1

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO boostorg/lambda2
    REF boost-1.81.0
    SHA512 e9e07866168c8596926eb2c68a6dc9ee89a0ca3400edd751f02e1e6cda4799b4d6e932e49dca2d36ae932963b65b70fc1141145802488b872be8acb59338b32e
    HEAD_REF master
)

include(${CURRENT_INSTALLED_DIR}/share/boost-vcpkg-helpers/boost-modular-headers.cmake)
boost_modular_headers(SOURCE_PATH ${SOURCE_PATH})
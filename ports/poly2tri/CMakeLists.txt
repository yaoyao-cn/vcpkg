cmake_minimum_required(VERSION 3.14)

project(poly2tri)

file(GLOB SOURCES poly2tri/common/*.cc poly2tri/sweep/*.cc)

add_library(poly2tri STATIC ${SOURCES})

install(TARGETS poly2tri)


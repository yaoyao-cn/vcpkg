cmake_minimum_required(VERSION 3.14)

project(md5)

add_library(md5 STATIC md5.cpp md5.h)

install(
    FILES md5.h
    DESTINATION include
)

install(
    FILES LICENSE
    DESTINATION share/md5
    RENAME copyright 
)

install(TARGETS md5)


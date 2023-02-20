cmake_minimum_required(VERSION 3.0)
project ( squashfuse LANGUAGES C )

find_package( PkgConfig REQUIRED )
find_package( zstd CONFIG REQUIRED )

pkg_check_modules( FUSE REQUIRED fuse )

add_library( squashfuse )

target_sources( squashfuse PRIVATE
    cache.c
    decompress.c
    dir.c
    extract.c
    file.c
    fs.c
    fuseprivate.c
    hash.c
    hl.c
    ll.c
    ll_inode.c
    ls.c
    nonstd-daemon.c
    nonstd-enoattr.c
    nonstd-makedev.c
    nonstd-pread.c
    nonstd-stat.c
    nonstd-symlink.c
    stack.c
    stat.c
    swap.c
    table.c
    traverse.c
    util.c
    xattr.c
    )
target_include_directories( squashfuse PRIVATE ${CMAKE_CURRENT_SOURCE_DIR} ${FUSE_INCLUDE_DIRS} )
target_link_libraries( squashfuse PUBLIC zstd::libzstd_static ${FUSE_LIBRARIES} )
target_compile_options( squashfuse PRIVATE ${FUSE_CFLAGS_OTHER} )

file( MAKE_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/include )

set( PACKAGE_VERSION "0.1.104" )
configure_file( ${CMAKE_CURRENT_SOURCE_DIR}/config.h.in ${CMAKE_CURRENT_BINARY_DIR}/include/config.h )
configure_file( ${CMAKE_CURRENT_SOURCE_DIR}/swap.c.inc ${CMAKE_CURRENT_BINARY_DIR}/swap.c.inc )
configure_file( ${CMAKE_CURRENT_SOURCE_DIR}/swap.h.inc ${CMAKE_CURRENT_BINARY_DIR}/swap.h.inc )

set( HEADER_FILES
    cache.h
    common.h
    decompress.h
    dir.h
    file.h
    fs.h
    fuseprivate.h
    hash.h
    ll.h
    nonstd.h
    squashfs_fs.h
    squashfuse.h
    stack.h
    stat.h
    swap.h
    table.h
    traverse.h
    util.h
    xattr.h
    )
set( HEADER_PATHS )
foreach( HEADER ${HEADER_FILES} )
    list( APPEND HEADER_PATHS ${CMAKE_CURRENT_SOURCE_DIR}/${HEADER})
endforeach()
list( APPEND HEADER_PATHS ${CMAKE_CURRENT_BINARY_DIR}/include/config.h )

target_include_directories( squashfuse PRIVATE ${CMAKE_CURRENT_BINARY_DIR}/include )

install( TARGETS squashfuse EXPORT squashfuse ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR} )
install( TARGETS squashfuse LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR} )
if(${CMAKE_BUILD_TYPE} STREQUAL Release)
    install( FILES 
        ${HEADER_PATHS}
        DESTINATION ${CMAKE_INSTALL_PREFIX}/include/squashfuse
        )
endif()

include( CMakePackageConfigHelpers )
write_basic_package_version_file(
    ${CMAKE_CURRENT_BINARY_DIR}/squashfuseConfigVersion.cmake
    VERSION 0.1.104
    COMPATIBILITY SameMinorVersion
    )

export( EXPORT squashfuse
    FILE ${CMAKE_CURRENT_BINARY_DIR}/squashfuseTargets.cmake
    NAMESPACE squashfuse::
    )
install( EXPORT squashfuse DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/squashfuse )
install( EXPORT squashfuse 
    FILE squashfuseTargets.cmake 
    NAMESPACE squashfuse:: 
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/squashfuse
    )
install( FILES 
    squashfuseConfig.cmake 
    ${CMAKE_CURRENT_BINARY_DIR}/squashfuseConfigVersion.cmake 
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/squashfuse
    )

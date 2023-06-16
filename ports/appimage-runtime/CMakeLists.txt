cmake_minimum_required(VERSION 3.0)
project ( appimageruntime LANGUAGES C )

find_package( squashfuse REQUIRED )
find_package( PkgConfig )
find_package( Threads REQUIRED )
find_package( zstd CONFIG REQUIRED )

pkg_check_modules( FUSE REQUIRED fuse )

add_executable( runtime )

target_sources( runtime PRIVATE src/runtime/runtime.c )
target_include_directories( runtime PRIVATE ${FUSE_INCLUDE_DIRS} )
target_link_libraries( runtime PRIVATE squashfuse::squashfuse Threads::Threads ${FUSE_LIBRARIES} )
target_compile_options( runtime PRIVATE
    -DGIT_COMMIT="0000"
    -T src/runtime/data_sections.ld
    -ffunction-sections
    -fdata-sections
    -Wl,--gc-sections
    ${FUSE_CFLAGS_OTHER}
    )

add_custom_command( 
    TARGET runtime
    POST_BUILD
    COMMAND dd 
    ARGS
        if=${CMAKE_CURRENT_SOURCE_DIR}/mime_magic 
        of=$<TARGET_FILE:runtime> 
        bs=1 count=3 seek=8 conv=notrunc
    )

install( TARGETS runtime RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR} )

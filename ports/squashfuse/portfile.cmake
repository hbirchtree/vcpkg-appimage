vcpkg_download_distfile(ARCHIVE
    URLS https://github.com/vasi/squashfuse/archive/e51978c.tar.gz
    FILENAME squashfuse.tar.gz
    SHA512 f3b78d23b3c60b23908de6b859a484bce5dc026890ca116e20501666f452f689e579cbf3dadb5966c9dc3506c3ca2f3b97dd20fc72e6fedfb35e1f0a36818fac
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

file(COPY ${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt DESTINATION ${SOURCE_PATH})
file(COPY ${CMAKE_CURRENT_LIST_DIR}/squashfuseConfig.cmake DESTINATION ${SOURCE_PATH})
file(COPY ${CMAKE_CURRENT_LIST_DIR}/config.h.in DESTINATION ${SOURCE_PATH})
file(COPY ${CMAKE_CURRENT_LIST_DIR}/swap.c.inc DESTINATION ${SOURCE_PATH})
file(COPY ${CMAKE_CURRENT_LIST_DIR}/swap.h.inc DESTINATION ${SOURCE_PATH})

vcpkg_cmake_configure(
    SOURCE_PATH ${SOURCE_PATH}
)

vcpkg_cmake_install()

file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)

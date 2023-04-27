vcpkg_download_distfile(ARCHIVE
    URLS https://github.com/AppImage/type2-runtime/archive/refs/heads/main.tar.gz
    FILENAME type2-runtime-main.tar.gz
    SHA512 b29fe101a101c63dc1e07957d29ae6d22e1634dd539270e59e4c79f2e51a0ed0d64b8e2b15fe1d5a38d96a10763fe8f8428278ca26d13faa4d5efc9e3c004e75
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

file(COPY ${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt DESTINATION ${SOURCE_PATH})
file(COPY ${CMAKE_CURRENT_LIST_DIR}/mime_magic DESTINATION ${SOURCE_PATH})

vcpkg_cmake_configure(
    SOURCE_PATH ${SOURCE_PATH}
)

vcpkg_cmake_install()

file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)

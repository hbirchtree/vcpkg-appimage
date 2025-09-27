vcpkg_download_distfile(ARCHIVE
    URLS https://github.com/AppImage/type2-runtime/archive/61e66889c26d12cf0492a835ff80fed39a14ab77.tar.gz
    FILENAME type2-runtime-main.tar.gz
    SHA512 9643f9d3dc4355dfdb3e1272e301d330fd0997837d48e0ae153ff367f164c5811e37f02aa9a97bf9c12f370d36328c00788082977c0bc988dfc1e54336ac4e18
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

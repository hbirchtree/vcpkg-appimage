vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO AppImage/type2-runtime
    REF 9594e2b1306a83b1020145f4e4e29c61065536a4
    SHA512 5e6a9f09fbfeb2cc6ac55c0f5d43b979e8e67af560968389746605386e0ec21d2a890ff39e7fc319ae682b3557e067339ca9c88daa8522407bbd96239e8569e8
    HEAD_REF main
    PATCHES
        fix-fuse.patch
)
#vcpkg_download_distfile(ARCHIVE
#    URLS https://github.com/AppImage/type2-runtime/archive/9594e2b1306a83b1020145f4e4e29c61065536a4.tar.gz
#    FILENAME type2-runtime-main.tar.gz
#    SHA512 5e6a9f09fbfeb2cc6ac55c0f5d43b979e8e67af560968389746605386e0ec21d2a890ff39e7fc319ae682b3557e067339ca9c88daa8522407bbd96239e8569e8
#)
#
#vcpkg_extract_source_archive_ex(
#    OUT_SOURCE_PATH SOURCE_PATH
#    ARCHIVE ${ARCHIVE}
#)

file(COPY ${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt DESTINATION ${SOURCE_PATH})
file(COPY ${CMAKE_CURRENT_LIST_DIR}/mime_magic DESTINATION ${SOURCE_PATH})

vcpkg_cmake_configure(
    SOURCE_PATH ${SOURCE_PATH}
)

vcpkg_cmake_install()

file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)

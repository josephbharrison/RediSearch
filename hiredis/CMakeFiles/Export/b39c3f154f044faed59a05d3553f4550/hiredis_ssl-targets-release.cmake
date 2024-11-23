#----------------------------------------------------------------
# Generated CMake target import file for configuration "Release".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "hiredis::hiredis_ssl" for configuration "Release"
set_property(TARGET hiredis::hiredis_ssl APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(hiredis::hiredis_ssl PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "C"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libhiredis_ssl.a"
  )

list(APPEND _cmake_import_check_targets hiredis::hiredis_ssl )
list(APPEND _cmake_import_check_files_for_hiredis::hiredis_ssl "${_IMPORT_PREFIX}/lib/libhiredis_ssl.a" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)

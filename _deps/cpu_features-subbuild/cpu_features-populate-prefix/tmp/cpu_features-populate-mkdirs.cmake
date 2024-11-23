# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.

cmake_minimum_required(VERSION ${CMAKE_VERSION}) # this file comes with cmake

# If CMAKE_DISABLE_SOURCE_CHANGES is set to true and the source directory is an
# existing directory in our source tree, calling file(MAKE_DIRECTORY) on it
# would cause a fatal error, even though it would be a no-op.
if(NOT EXISTS "/Users/work/code/RediSearch/_deps/cpu_features-src")
  file(MAKE_DIRECTORY "/Users/work/code/RediSearch/_deps/cpu_features-src")
endif()
file(MAKE_DIRECTORY
  "/Users/work/code/RediSearch/_deps/cpu_features-build"
  "/Users/work/code/RediSearch/_deps/cpu_features-subbuild/cpu_features-populate-prefix"
  "/Users/work/code/RediSearch/_deps/cpu_features-subbuild/cpu_features-populate-prefix/tmp"
  "/Users/work/code/RediSearch/_deps/cpu_features-subbuild/cpu_features-populate-prefix/src/cpu_features-populate-stamp"
  "/Users/work/code/RediSearch/_deps/cpu_features-subbuild/cpu_features-populate-prefix/src"
  "/Users/work/code/RediSearch/_deps/cpu_features-subbuild/cpu_features-populate-prefix/src/cpu_features-populate-stamp"
)

set(configSubDirs )
foreach(subDir IN LISTS configSubDirs)
    file(MAKE_DIRECTORY "/Users/work/code/RediSearch/_deps/cpu_features-subbuild/cpu_features-populate-prefix/src/cpu_features-populate-stamp/${subDir}")
endforeach()
if(cfgdir)
  file(MAKE_DIRECTORY "/Users/work/code/RediSearch/_deps/cpu_features-subbuild/cpu_features-populate-prefix/src/cpu_features-populate-stamp${cfgdir}") # cfgdir has leading slash
endif()

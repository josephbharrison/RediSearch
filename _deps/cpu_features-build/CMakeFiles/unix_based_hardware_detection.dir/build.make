# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.31

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Disable VCS-based implicit rules.
% : %,v

# Disable VCS-based implicit rules.
% : RCS/%

# Disable VCS-based implicit rules.
% : RCS/%,v

# Disable VCS-based implicit rules.
% : SCCS/s.%

# Disable VCS-based implicit rules.
% : s.%

.SUFFIXES: .hpux_make_needs_suffix_list

# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /opt/homebrew/bin/cmake

# The command to remove a file.
RM = /opt/homebrew/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /Users/work/code/RediSearch

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /Users/work/code/RediSearch

# Include any dependencies generated for this target.
include _deps/cpu_features-build/CMakeFiles/unix_based_hardware_detection.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include _deps/cpu_features-build/CMakeFiles/unix_based_hardware_detection.dir/compiler_depend.make

# Include the progress variables for this target.
include _deps/cpu_features-build/CMakeFiles/unix_based_hardware_detection.dir/progress.make

# Include the compile flags for this target's objects.
include _deps/cpu_features-build/CMakeFiles/unix_based_hardware_detection.dir/flags.make

_deps/cpu_features-build/CMakeFiles/unix_based_hardware_detection.dir/codegen:
.PHONY : _deps/cpu_features-build/CMakeFiles/unix_based_hardware_detection.dir/codegen

_deps/cpu_features-build/CMakeFiles/unix_based_hardware_detection.dir/src/hwcaps.c.o: _deps/cpu_features-build/CMakeFiles/unix_based_hardware_detection.dir/flags.make
_deps/cpu_features-build/CMakeFiles/unix_based_hardware_detection.dir/src/hwcaps.c.o: _deps/cpu_features-src/src/hwcaps.c
_deps/cpu_features-build/CMakeFiles/unix_based_hardware_detection.dir/src/hwcaps.c.o: _deps/cpu_features-build/CMakeFiles/unix_based_hardware_detection.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --progress-dir=/Users/work/code/RediSearch/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object _deps/cpu_features-build/CMakeFiles/unix_based_hardware_detection.dir/src/hwcaps.c.o"
	cd /Users/work/code/RediSearch/_deps/cpu_features-build && /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/clang $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT _deps/cpu_features-build/CMakeFiles/unix_based_hardware_detection.dir/src/hwcaps.c.o -MF CMakeFiles/unix_based_hardware_detection.dir/src/hwcaps.c.o.d -o CMakeFiles/unix_based_hardware_detection.dir/src/hwcaps.c.o -c /Users/work/code/RediSearch/_deps/cpu_features-src/src/hwcaps.c

_deps/cpu_features-build/CMakeFiles/unix_based_hardware_detection.dir/src/hwcaps.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Preprocessing C source to CMakeFiles/unix_based_hardware_detection.dir/src/hwcaps.c.i"
	cd /Users/work/code/RediSearch/_deps/cpu_features-build && /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/clang $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /Users/work/code/RediSearch/_deps/cpu_features-src/src/hwcaps.c > CMakeFiles/unix_based_hardware_detection.dir/src/hwcaps.c.i

_deps/cpu_features-build/CMakeFiles/unix_based_hardware_detection.dir/src/hwcaps.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Compiling C source to assembly CMakeFiles/unix_based_hardware_detection.dir/src/hwcaps.c.s"
	cd /Users/work/code/RediSearch/_deps/cpu_features-build && /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/clang $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /Users/work/code/RediSearch/_deps/cpu_features-src/src/hwcaps.c -o CMakeFiles/unix_based_hardware_detection.dir/src/hwcaps.c.s

unix_based_hardware_detection: _deps/cpu_features-build/CMakeFiles/unix_based_hardware_detection.dir/src/hwcaps.c.o
unix_based_hardware_detection: _deps/cpu_features-build/CMakeFiles/unix_based_hardware_detection.dir/build.make
.PHONY : unix_based_hardware_detection

# Rule to build all files generated by this target.
_deps/cpu_features-build/CMakeFiles/unix_based_hardware_detection.dir/build: unix_based_hardware_detection
.PHONY : _deps/cpu_features-build/CMakeFiles/unix_based_hardware_detection.dir/build

_deps/cpu_features-build/CMakeFiles/unix_based_hardware_detection.dir/clean:
	cd /Users/work/code/RediSearch/_deps/cpu_features-build && $(CMAKE_COMMAND) -P CMakeFiles/unix_based_hardware_detection.dir/cmake_clean.cmake
.PHONY : _deps/cpu_features-build/CMakeFiles/unix_based_hardware_detection.dir/clean

_deps/cpu_features-build/CMakeFiles/unix_based_hardware_detection.dir/depend:
	cd /Users/work/code/RediSearch && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /Users/work/code/RediSearch /Users/work/code/RediSearch/_deps/cpu_features-src /Users/work/code/RediSearch /Users/work/code/RediSearch/_deps/cpu_features-build /Users/work/code/RediSearch/_deps/cpu_features-build/CMakeFiles/unix_based_hardware_detection.dir/DependInfo.cmake "--color=$(COLOR)"
.PHONY : _deps/cpu_features-build/CMakeFiles/unix_based_hardware_detection.dir/depend


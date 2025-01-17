############################################################################
# PlatformAndroid.cmake
# Copyright (C) 2010-2023 Belledonne Communications, Grenoble France
#
############################################################################
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
#
############################################################################

include("${CMAKE_CURRENT_LIST_DIR}/PlatformCommon.cmake")


# Force ffmpeg to be disabled
set(ENABLE_FFMPEG OFF CACHE BOOL "Build mediastreamer2 with ffmpeg video support." FORCE)


if(LINPHONESDK_BUILD_TYPE STREQUAL "Default")
	set(CMAKE_INSTALL_RPATH "$ORIGIN")

	# Copy c++ library to install prefix
	# The library has to be present for cmake dependencies and before the install target
	if(CMAKE_ANDROID_NDK_VERSION VERSION_LESS 25)
		file(COPY "${CMAKE_ANDROID_NDK}/sources/cxx-stl/llvm-libc++/libs/${CMAKE_ANDROID_ARCH_ABI}/libc++_shared.so" DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/")
	else()
		if(CMAKE_SYSTEM_PROCESSOR STREQUAL "armv7-a")
			set(_ndk_sysroot "arm-linux-androideabi")
		elseif(CMAKE_SYSTEM_PROCESSOR STREQUAL "aarch64")
			set(_ndk_sysroot "aarch64-linux-android")
		elseif(CMAKE_SYSTEM_PROCESSOR STREQUAL "i686")
			set(_ndk_sysroot "i686-linux-android")
		elseif(CMAKE_SYSTEM_PROCESSOR STREQUAL "x86_64")
			set(_ndk_sysroot "x86_64-linux-android")
		else()
			set(_ndk_sysroot "${CMAKE_SYSTEM_PROCESSOR}")
		endif()
		file(COPY "${CMAKE_ANDROID_NDK}/toolchains/llvm/prebuilt/${ANDROID_HOST_TAG}/sysroot/usr/lib/${_ndk_sysroot}/libc++_shared.so" DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/")
	endif()

	if(ENABLE_SANITIZER)
		set(SANITIZER_ARCH ${CMAKE_SYSTEM_PROCESSOR})
		if(SANITIZER_ARCH MATCHES "^arm")
			set(SANITIZER_ARCH "arm")
		endif()
		
		file(GLOB_RECURSE _clang_rt_library "${CMAKE_ANDROID_NDK}/toolchains/llvm/prebuilt/${ANDROID_HOST_TAG}/*/clang/*/lib/linux/libclang_rt.asan-${SANITIZER_ARCH}-android.so")
		if(_clang_rt_library)
			list(GET _clang_rt_library 0 _clang_rt_library)
			file(COPY ${_clang_rt_library} DESTINATION "${CMAKE_INSTALL_PREFIX}/lib")
		
	    #DO NOT REMOVE NOW  !!!
	    # It SEEMS to be useless as the sanitizer builds without these lines on ndk 20 and sdk 28.
	    # Need to check with others versions.

	  	#we search for liblog.so in the folder of the ndk, then if it is found we add it to the linker flags
			#find_library(log_library log PATHS "${CMAKE_ANDROID_NDK}/toolchains/llvm/prebuilt/${ANDROID_HOST_TAG}/sysroot/")
			#if(NOT DEFINED log_library-NOTFOUND)
			  #set(CMAKE_EXE_LINKER_FLAGS "${_clang_rt_library} ${log_library} ${CMAKE_EXE_LINKER_FLAGS}")
			 # message("if find library config android")
	 		 # message("if find library config android CMAKE_EXE_LINKER_FLAGS = ${CMAKE_EXE_LINKER_FLAGS}")
			 # message("if find library config android _clang_rt_library = ${_clang_rt_library}")
	 		 # message("if find library config android log_library = ${log_library}")
			#else()
			#  message(fatal_error "LOG LIBRARY NOT FOUND. It is mandatory for the Android Sanitizer")
			#endif()
		  
			configure_file("${CMAKE_CURRENT_LIST_DIR}/Android/wrap.sh.cmake" "lib/wrap.sh" @ONLY)
		endif()
	endif()

	if(CMAKE_BUILD_TYPE STREQUAL "Debug")
		# GDB server setup
		add_subdirectory("cmake/Android/gdbserver")

		# Dummy script to not strip compiled libs from the general Makefile
		file(WRITE "${PROJECT_BINARY_DIR}/strip.sh" "")
	else()
		# Script to be able to strip compiled libs from the general Makefile
		configure_file("${CMAKE_CURRENT_LIST_DIR}/Android/strip.sh.cmake" "strip.sh" @ONLY)
	endif()

endif()

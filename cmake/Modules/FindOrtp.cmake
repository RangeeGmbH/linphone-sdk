############################################################################
# FindOrtp.cmake
# Copyright (C) 2023  Belledonne Communications, Grenoble France
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
#
# Find the ortp library.
#
# Targets
# ^^^^^^^
#
# The following targets may be defined:
#
#  ortp - If the ortp library has been found
#
#
# Result variables
# ^^^^^^^^^^^^^^^^
#
# This module will set the following variables in your project:
#
#  Ortp_FOUND - The ortp library has been found
#  Ortp_TARGET - The name of the CMake target for the ortp library


set(_Ortp_REQUIRED_VARS Ortp_TARGET)
set(_Ortp_CACHE_VARS ${_Ortp_REQUIRED_VARS})

if(TARGET ortp)
	set(Ortp_TARGET ortp)
endif()

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(Ortp
	REQUIRED_VARS ${_Ortp_REQUIRED_VARS}
	HANDLE_COMPONENTS
)
mark_as_advanced(${_Ortp_CACHE_VARS})

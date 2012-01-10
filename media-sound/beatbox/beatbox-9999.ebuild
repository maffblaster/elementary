# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit fdo-mime gnome2-utils cmake-utils bzr

DESCRIPTION="A music player written for the elementary project"
HOMEPAGE="https://launchpad.net/beat-box"
EBZR_REPO_URI="lp:beat-box"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="ayatana menu zeitgeist"

RDEPEND="
	dev-db/sqlheavy:0.1
	>=dev-libs/glib-2.26:2
	>=dev-libs/json-glib-0.10
	dev-libs/libgee:0
	x11-libs/granite
	x11-libs/libnotify
	>=dev-libs/libxml2-2.7.7:2
	>=gnome-base/gconf-2.31.91:2
	>=media-libs/gstreamer-0.10
	>=media-libs/gst-plugins-base-0.10
	>=media-libs/taglib-1.6.3
	>=net-libs/libsoup-2.25.2:2.4
	ayatana? ( >=dev-libs/libindicate-0.5.90 )
	zeitgeist? ( >=dev-libs/libzeitgeist-0.3.10 )
	menu? ( >=dev-libs/libdbusmenu-0.4.3 )
	x11-libs/gtk+:3"
DEPEND="${RDEPEND}
	dev-lang/vala:0.14"

src_configure() {
	local mycmakeargs=(
		-DGSETTINGS_COMPILE=OFF
		-DVALA_EXECUTABLE="$(type -p valac-0.14)"
	)

	cmake-utils_src_configure
}

pkg_preinst() {
	gnome2_icon_savelist
	gnome2_schemas_savelist
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	gnome2_icon_cache_update
	gnome2_schemas_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	gnome2_icon_cache_update
	gnome2_schemas_update --uninstall
}


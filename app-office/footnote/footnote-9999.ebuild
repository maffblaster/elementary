# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit fdo-mime gnome2-utils cmake-utils bzr

DESCRIPTION="Beautiful, fast, and simple note taking app in the style of
elementary"
HOMEPAGE="https://launchpad.net/footnote"
EBZR_REPO_URI="lp:footnote"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="
	dev-libs/glib:2
	dev-libs/libgee
	dev-db/sqlheavy:0.1
	x11-libs/granite
    x11-libs/gtk+:3"
DEPEND="${RDEPEND}
	dev-lang/vala:0.14"

src_configure() {
	local mycmakeargs=(
		-DVALA_EXECUTABLE=$(type -p valac-0.14)
	)

	cmake-utils_src_configure
}

pkg_postinst() {
	fdo-mime_desktop_database_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
}


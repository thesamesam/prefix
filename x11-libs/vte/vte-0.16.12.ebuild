# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/vte/vte-0.16.12.ebuild,v 1.1 2008/01/09 21:36:17 eva Exp $

EAPI="prefix"

inherit eutils gnome2 autotools python

DESCRIPTION="Gnome terminal widget"
HOMEPAGE="http://www.gnome.org/"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86-fbsd ~amd64-linux ~ia64-linux ~x86-linux"
# pcre is broken in this release
IUSE="debug doc python opengl"

RDEPEND=">=dev-libs/glib-2.9
	>=x11-libs/gtk+-2.6
	>=x11-libs/pango-1.1
	>=media-libs/freetype-2.0.2
	media-libs/fontconfig
	sys-libs/ncurses
	opengl? (
		virtual/opengl
		virtual/glu
	)
	python? (
		>=dev-python/pygtk-2.4
		>=dev-lang/python-2.4.4-r5
	)
	x11-libs/libX11
	virtual/xft"

DEPEND="${RDEPEND}
	doc? ( >=dev-util/gtk-doc-1.0 )
	>=dev-util/intltool-0.35
	>=dev-util/pkgconfig-0.9
	sys-devel/gettext"

DOCS="AUTHORS ChangeLog HACKING NEWS README"

pkg_setup() {
	G2CONF="${G2CONF} $(use_enable debug) $(use_enable python)
		$(use_with opengl glX) --with-xft2 --with-pangox"
}

src_unpack() {
	gnome2_src_unpack

	epatch "${FILESDIR}/${PN}-0.13.2-no-lazy-bindings.patch"
	cd "${S}/gnome-pty-helper"

	# eautoreconf will break on systems without gtk-doc
	eautomake
}

pkg_postinst() {
	if use python; then
		python_version
		python_mod_optimize "${EROOT}usr/$(get_libdir)/python${PYVER}/site-packages/gtk-2.0"
	fi
}

pkg_postrm() {
	if use python; then
		python_version
		python_mod_cleanup "${EROOT}usr/$(get_libdir)/python${PYVER}/site-packages/gtk-2.0"
	fi
}

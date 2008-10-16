# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmdf/wmdf-0.1.6-r1.ebuild,v 1.6 2008/10/16 02:00:13 darkside Exp $

EAPI="prefix"

inherit eutils

DESCRIPTION="An app to monitor disk space on partitions"
SRC_URI="http://dockapps.org/download.php/id/359/${P}.tar.gz"
HOMEPAGE="http://dockapps.org/file.php/id/175"

RDEPEND="x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXt
	x11-libs/libXpm"
DEPEND="${RDEPEND}
	x11-proto/xextproto"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86-linux"
IUSE=""

src_unpack() {
	unpack ${A}
	cd "${S}"/src

	# Remove special filesystem entries, see bug #97856
	epatch "${FILESDIR}"/wmdf_sys-fs.patch

	# Remove non-implemented command line args from 'wmdf -h' listing
	epatch "${FILESDIR}"/wmdf_cmd_line_args.patch
}

src_install() {
	einstall || die "Install failed"
	dodoc README AUTHORS ChangeLog NEWS THANKS TODO
}

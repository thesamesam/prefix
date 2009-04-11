# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/planet/planet-20040808.ebuild,v 1.7 2007/02/28 22:25:49 genstef Exp $

DESCRIPTION="App to create sites like http://planet.kde.org/"
HOMEPAGE="http://planetplanet.org/"
SRC_URI="http://dev.gentoo.org/~stuart/planet/${P}.tar.bz2"
LICENSE="PSF-2.2"
KEYWORDS="~x86-linux ~ppc-macos"
IUSE=""
SLOT=0
DEPEND=""

S=${WORKDIR}/${PN}-nightly

DOCS="AUTHORS README INSTALL ChangeLog"

src_install ()
{
	dodoc $DOCS
	rm -f $DOCS

	dodir /usr/lib/planet
	cp -R * ${ED}/usr/lib/planet
}

pkg_postinst ()
{
	elog
	elog "Planet has been installed into /usr/lib/planet.  You will"
	elog "probably want to copy these files into a directory of your own"
	elog "before changing the templates and configuration file."
	elog
}

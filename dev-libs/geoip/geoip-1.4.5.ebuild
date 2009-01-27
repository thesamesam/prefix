# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/geoip/geoip-1.4.5.ebuild,v 1.6 2008/12/28 18:20:32 pva Exp $

EAPI="prefix"

inherit autotools eutils libtool

MY_P="${P/geoip/GeoIP}"
DESCRIPTION="easily lookup countries by IP addresses, even when Reverse DNS entries don't exist"
HOMEPAGE="http://www.maxmind.com/geoip/api/c.shtml"
SRC_URI="http://www.maxmind.com/download/geoip/api/c/${MY_P}.tar.gz"

# GPL-2 for md5.c - part of libGeoIPUpdate, MaxMind for GeoLite Country db
LICENSE="LGPL-2.1 GPL-2 MaxMind"
SLOT="0"
KEYWORDS="~x86-freebsd ~amd64-linux ~ia64-linux ~x86-linux"
IUSE=""

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${PN}-1.4.4-parallel-build.patch
	epatch "${FILESDIR}"/${PN}-1.4.4-no-noinst_PROGRAMS.patch
	epatch "${FILESDIR}"/${P}-ppc-fix.patch
	eautoreconf
	# FreeBSD requires this
	#elibtoolize
}

src_compile() {
	econf --enable-shared
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dobin apps/geoipupdate-pureperl.pl
	dodoc AUTHORS ChangeLog README TODO
	newdoc data/README README.data
}

# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-scheme/gauche/gauche-0.8.12.ebuild,v 1.1 2007/12/15 11:51:35 hattya Exp $

EAPI="prefix"

inherit autotools eutils flag-o-matic

IUSE="ipv6"

MY_P="${P/g/G}"

DESCRIPTION="A Unix system friendly Scheme Interpreter"
HOMEPAGE="http://gauche.sf.net/"
SRC_URI="mirror://sourceforge/gauche/${MY_P}.tgz"

LICENSE="BSD"
KEYWORDS="~amd64-linux ~ia64-linux ~x86-linux ~x86-macos"
SLOT="0"
S="${WORKDIR}/${MY_P}"

DEPEND=">=sys-libs/gdbm-1.8.0"

src_unpack() {

	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${PN}-gauche.m4.diff
	epatch "${FILESDIR}"/${PN}-runpath.diff
	eautoconf

}

src_compile() {

	strip-flags

	econf \
		`use_enable ipv6` \
		--enable-multibyte=utf8 \
		--with-slib="${EPREFIX}"/usr/share/slib \
		|| die
	emake -j1 || die

}

src_test() {

	emake -j1 -s check || die

}

src_install() {

	emake DESTDIR="${D}" install-pkg install-doc || die
	dodoc AUTHORS ChangeLog HACKING README

}

# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/autoconf-wrapper/autoconf-wrapper-7.ebuild,v 1.1 2009/07/27 04:15:07 vapier Exp $

inherit multilib

DESCRIPTION="wrapper for autoconf to manage multiple autoconf versions"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc-aix ~x64-freebsd ~x86-freebsd ~hppa-hpux ~ia64-hpux ~x86-interix ~amd64-linux ~ia64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~m68k-mint ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE=""

S=${WORKDIR}

src_install() {
	exeinto /usr/$(get_libdir)/misc
	newexe "${FILESDIR}"/ac-wrapper-${PV}.sh ac-wrapper.sh || die

	dodir /usr/bin
	local x=
	for x in auto{conf,header,m4te,reconf,scan,update} ifnames ; do
		dosym ../$(get_libdir)/misc/ac-wrapper.sh /usr/bin/${x} || die
	done
}

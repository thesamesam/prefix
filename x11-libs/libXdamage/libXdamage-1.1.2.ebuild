# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libXdamage/libXdamage-1.1.2.ebuild,v 1.5 2009/12/27 18:05:16 josejx Exp $

inherit x-modular

DESCRIPTION="X.Org Xdamage library"

KEYWORDS="~x64-freebsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris ~x86-winnt"
IUSE=""

RDEPEND="x11-libs/libX11
	x11-libs/libXfixes
	>=x11-proto/damageproto-1.1
	x11-proto/xproto"
DEPEND="${RDEPEND}"

# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Params-Validate/Params-Validate-0.88.ebuild,v 1.6 2007/08/09 15:09:59 dertobi123 Exp $

EAPI="prefix"

inherit perl-module

DESCRIPTION="A module to provide a flexible system for validation method/function call parameters"
SRC_URI="mirror://cpan/authors/id/D/DR/DROLSKY/${P}.tar.gz"
HOMEPAGE="http://search.perl.com/~drolsky/${P}/"

SRC_TEST="do"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ia64 ~x86 ~x86-fbsd ~x86-macos"
IUSE=""

src_install () {
	perl-module_src_install
	dohtml htdocs/*
}

DEPEND="dev-lang/perl"

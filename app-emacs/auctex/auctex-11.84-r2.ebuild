# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/auctex/auctex-11.84-r2.ebuild,v 1.7 2007/11/27 22:27:57 angelos Exp $

EAPI="prefix"

inherit elisp eutils latex-package

DESCRIPTION="An extensible package that supports writing and formatting TeX files"
HOMEPAGE="http://www.gnu.org/software/auctex/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz"

LICENSE="GPL-2 FDL-1.2"
SLOT="0"
KEYWORDS="~amd64 ~ppc-macos ~sparc-solaris ~x86 ~x86-macos"
IUSE="preview-latex"

DEPEND="virtual/tetex
	preview-latex? ( !dev-tex/preview-latex
		app-text/dvipng
		virtual/ghostscript )"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# skip XEmacs detection. this is a workaround for emacs23
	epatch "${FILESDIR}/${P}-configure.diff"
	# allow compilation of Japanese TeX files, fixed in upstream's CVS
	# not needed for next release (>=11.85)
	epatch "${FILESDIR}/${P}-japanes.patch"
}

src_compile() {
	# Don't install in the main tree, as this causes file collisions
	# with app-text/tetex, see bug #155944
	if use preview-latex; then
		local TEXMFPATH="$(kpsewhich -var-value=TEXMFSITE)"
		local TEXMFCONFIGFILE="$(kpsewhich texmf.cnf)"

		if [ -z "${TEXMFPATH}" ]; then
			eerror "You haven't defined the TEXMFSITE variable in your TeX config."
			eerror "Please do so in the file ${TEXMFCONFIGFILE:-/var/lib/texmf/web2c/texmf.cnf}"
			die "Define TEXMFSITE in TeX configuration!"
		else
			# go through the colon separated list of directories (maybe only one) provided in the variable
			# TEXMFPATH (generated from TEXMFSITE from TeX's config) and choose only the first entry.
			# All entries are separated by colons, even when defined with semi-colons, kpsewhich changes
			# the output to a generic format, so IFS has to be redefined.
			local IFS="${IFS}:"

			for strippedpath in ${TEXMFPATH}
			do
				if [ -d ${strippedpath} ]; then
					local PREVIEW_TEXMFDIR="${strippedpath}"
					break
				fi
			done

			# verify if an existing path was chosen to prevent from installing into the wrong directory
			if [ -z ${PREVIEW_TEXMFDIR} ]; then
				eerror "TEXMFSITE does not contain any existing directory."
				eerror "Please define an existing directory in your TeX config file"
				eerror "${TEXMFCONFIGFILE:-/var/lib/texmf/web2c/texmf.cnf} or create at least one of the there specified directories"
				die "TEXMFSITE variable did not contain an existing directory"
			fi

			dodir "${PREVIEW_TEXMFDIR}"
		fi
	fi

	econf --disable-build-dir-test \
		--with-auto-dir="${ED}/var/lib/auctex" \
		--with-lispdir="${ED}/${SITELISP}" \
		--with-texmf-dir="${ED}/${PREVIEW_TEXMFDIR}" \
		$(use_enable preview-latex preview) || die "econf failed"
	emake || die "emake failed"
	cd doc; emake tex-ref.pdf || die "creation of tex-ref.pdf failed"
}

src_install() {
	einstall || die "einstall failed"
	dosed "${SITELISP}/tex-site.el" || die "dosed failed"
	elisp-site-file-install "${FILESDIR}/52auctex-gentoo.el"
	if use preview-latex; then
		elisp-site-file-install "${FILESDIR}/60auctex-gentoo.el"
	fi
	dodoc ChangeLog CHANGES README RELEASE TODO FAQ INSTALL* doc/tex-ref.pdf
}

pkg_postinst() {
	# rebuild TeX-inputfiles-database
	use preview-latex && latex-package_pkg_postinst
	elisp-site-regen
}

pkg_postrm(){
	use preview-latex && latex-package_pkg_postrm
	elisp-site-regen
}

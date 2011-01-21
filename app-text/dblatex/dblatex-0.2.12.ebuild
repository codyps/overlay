# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

inherit distutils

DESCRIPTION="Transform DocBook using TeX macros"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
HOMEPAGE="http://dblatex.sourceforge.net/"

KEYWORDS="~x86 ~amd64"
IUSE=""
SLOT="0"
LICENSE="GPL-2"
DEPEND="|| ( ( app-text/texlive
			   dev-texlive/texlive-latexextra
			   dev-texlive/texlive-mathextra
			   dev-texlive/texlive-xetex
			 )
			 >=app-text/texlive-3
		   )
		 dev-libs/libxslt
		 app-text/docbook-xml-dtd
		 dev-texlive/texlive-pictures"

src_install() {
	distutils_src_install
	mv ${D}/usr/bin/dblatex ${D}/usr/bin/docbook2latex
	mv ${D}/usr/share/man/man1/dblatex.1.gz ${D}/usr/share/man/man1/docbook2latex.1.gz

	einfo "This package installs its main binary as"
	einfo "  docbook2latex"
	einfo "to avoid collisions with other latex packages."
}


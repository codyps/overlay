# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/byacc/byacc-1.9-r3.ebuild,v 1.8 2012/02/01 13:32:42 ulm Exp $

EAPI=2

inherit eutils toolchain-funcs

DESCRIPTION="The best variant of the Yacc parser generator"
HOMEPAGE="http://invisible-island.net/byacc/byacc.html"
SRC_URI="ftp://invisible-island.net/byacc/${P}.tgz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

src_compile() {
	emake THIS=byacc || die
}

src_install() {
	dobin byacc || die
	newman yacc.1 byacc.1 || die
	dodoc ACKNOWLEDGEMENTS NEW_FEATURES NOTES README || die
}

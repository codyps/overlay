# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/srecord/srecord-1.42.ebuild,v 1.2 2009/07/25 19:21:34 ssuominen Exp $

inherit eutils
EAPI="1"
DESCRIPTION="A collection of powerful tools for manipulating EPROM load files."
HOMEPAGE="http://srecord.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE="test"

RDEPEND=""
DEPEND="${RDEPEND}
	dev-libs/boost
	dev-libs/libgcrypt
	sys-apps/groff
	sys-devel/gcc[-nocxx]
	sys-devel/libtool"

src_install() {
	emake DESTDIR="${D}" install || die "Installation failed"
	dodoc "${S}"/README
	dodoc "${S}"/etc/reference.ps
}

src_test() {
	make sure || die "Tests failed"
}

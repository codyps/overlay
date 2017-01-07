# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils

if [ ${PV} = 9999 ]; then
	inherit git-2
	EGIT_REPO_URI="https://github.com/jmesmon/${PN}"
	KEYWORDS=""
else
	SRC_URI="http://point-at-infinity.org/${PN}/${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="an implementation of Shamir's secret sharing scheme"
HOMEPAGE="http://point-at-infinity.org/ssss/"

LICENSE="GPL-2"
SLOT="0"
IUSE=""

RDEPEND="dev-libs/gmp"
DEPEND="${RDEPEND}
	app-doc/xmltoman"

src_prepare() {
	if [ ${PV} != 9999 ]; then
		epatch "${FILESDIR}/${P}-fixup-makefile.patch"
		epatch "${FILESDIR}/0001-properly-zero-buffer.patch"
	fi
}

src_install() {
	dobin ssss-split ssss-combine
	doman ssss.1
}

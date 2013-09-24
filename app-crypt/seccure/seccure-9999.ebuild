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
	KEYWORDS="~amd64"
fi

DESCRIPTION="implements a selection of asymmetric algorithms based on elliptic curve cryptography (ECC)"
HOMEPAGE="http://point-at-infinity.org/seccure/"

LICENSE="GPL-2"
SLOT="0"
IUSE=""

RDEPEND="dev-libs/libgcrypt"
DEPEND="${RDEPEND}"

src_prepare() {
	epatch "${FILESDIR}/${P}-fixup-makefile.patch"
}


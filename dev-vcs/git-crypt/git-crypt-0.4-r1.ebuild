# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

if [[ "$PV" = 9999 ]]; then
	inherit git-2
	EGIT_REPO_URI="https://www.agwa.name/git/git-crypt.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/AGWA/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="transparent encryption and decryption of files in a git repository"
HOMEPAGE="https://www.agwa.name/git/git-crypt.git"

LICENSE="GPL-3+ openssl"
SLOT="0"
IUSE=""

RDEPEND="dev-libs/openssl:0 dev-vcs/git"
DEPEND="${RDEPEND}"

src_compile () {
	emake CXX="$(tc-getCXX)" CXXFLAGS="$CXXFLAGS $(pkg-config --cflags libcrypto)" LDFLAGS="$LDFLAGS $(pkg-config --libs libcrypto)"
}

src_install() {
	mkdir -p "${D}"/usr/bin
	emake PREFIX="${D}"/usr install
}

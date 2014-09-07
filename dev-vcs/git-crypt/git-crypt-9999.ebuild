# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils git-2
EGIT_REPO_URI="https://www.agwa.name/git/git-crypt.git"
KEYWORDS=""

DESCRIPTION="git-crypt enables transparent encryption and decryption of files in a
git repository"
HOMEPAGE="https://www.agwa.name/git/git-crypt.git"

LICENSE="GPL-3+ openssl"
SLOT="0"
IUSE=""

RDEPEND="dev-libs/openssl dev-vcs/git"
DEPEND="${RDEPEND}"

src_compile () {
	emake CXX="$(tc-getCXX)" CXXFLAGS="$CXXFLAGS $(pkg-config --cflags libcrypto)" LDFLAGS="$LDFLAGS $(pkg-config --libs libcrypto)"
}

src_install() {
	mkdir -p "${D}"/usr/bin
	emake PREFIX="${D}"/usr install
}

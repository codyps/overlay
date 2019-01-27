# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7

inherit eutils git-r3
EGIT_REPO_URI="https://github.com/StackExchange/${PN}.git"
KEYWORDS=""

DESCRIPTION="Safely store secrets in a VCS repo (i.e. Git or Mercurial)"
HOMEPAGE="https://github.com/StackExchange/blackbox.git"

LICENSE="MIT"
SLOT="0"
IUSE=""

RDEPEND="app-crypt/gnupg"
DEPEND="${RDEPEND}"

src_compile () {
	:
}

src_install() {
	dobin bin/*
	dodoc README.md
}

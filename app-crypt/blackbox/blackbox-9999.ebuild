# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils git-2
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
	dobin -r bin/
	dodoc README.md
}

# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI=5
inherit eutils git-2

DESCRIPTION="Tup is file oriented, directed acyclic graph based build system"
HOMEPAGE="http://gittup.org/tup/index.html"
EGIT_REPO_URI="https://github.com/gittup/tup.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="doc suid"

DEPEND="sys-fs/fuse"
RDEPEND="${DEPEND}"

src_compile() {
	# Needed for fuse mount
	addwrite /dev/fuse
	./bootstrap.sh
}

src_install() {
	dobin tup
	dolib.a libtup.a libtup_client.a
	doman tup.1

	use doc && dohtml -r docs
	use suid && fperms 4711 /usr/bin/tup
}

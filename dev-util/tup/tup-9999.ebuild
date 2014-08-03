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

src_prepare() {
	# Fix bootstrap respect for CC & LDFLAGS
	epatch "${FILESDIR}/0001-tup-allow-overriding-of-CC-and-extra-LDFLAGS-in-boot.patch"

	# Fix Tup respect for similar
	sed -i Tuprules.tup \
		-e "s:CC = gcc:CC = $(tc-getCC) ${CFLAGS} ${LDFLAGS}:" \
		-e "s:ar crs:$(tc-getAR) crs:"
}

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

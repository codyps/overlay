# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$
EAPI=5
inherit eutils

DESCRIPTION="Tup is file oriented, directed acyclic graph based build system"
HOMEPAGE="http://gittup.org/tup/index.html"
if [[ "${PV}" = 9999 ]]; then
	EGIT_REPO_URI="https://github.com/gittup/tup.git"
	inherit git-r3
	KEYWORDS=""
else
	SRC_URI="https://github.com/gittup/tup/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE="doc suid system-sqlite"

DEPEND="sys-fs/fuse"
RDEPEND="${DEPEND}"

src_prepare() {
	# Use our toolchain
	sed -i Tuprules.tup \
		-e "s:CC = gcc:CC = $(tc-getCC) ${CFLAGS} ${LDFLAGS}:" \
		-e "s:ar crs:$(tc-getAR) crs:"

	if [[ ${PV} != 9999 ]]; then
		# Avoid invoking `git` to find version, use ours
		sed -i Tupfile \
			-e 's;`git describe`;v'"${PV};"
	fi
}

src_configure () {
	use system-sqlite && echo "CONFIG_TUP_USE_SYSTEM_SQLITE=y" >> tup.config
}

src_compile() {
	TUP_NO_NAMESPACING=1 ./bootstrap-nofuse.sh
}

src_install() {
	dobin tup
	dolib.a libtup_client.a
	doheader tup_client.h
	doman tup.1

	use doc && dohtml -r docs
	use suid && fperms 4711 /usr/bin/tup
}

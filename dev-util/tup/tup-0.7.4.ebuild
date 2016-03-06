# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$
EAPI=5
inherit eutils git-r3

DESCRIPTION="Tup is file oriented, directed acyclic graph based build system"
HOMEPAGE="http://gittup.org/tup/index.html"
EGIT_REPO_URI="https://github.com/gittup/tup.git"
if [ "${PV}" = 9999 ]; then
	KEYWORDS=""
else
	EGIT_COMMIT="v${PV}"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE="doc suid system-sqlite"

DEPEND="sys-fs/fuse"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}/0001-tup-allow-overriding-of-CC-and-extra-LDFLAGS-in-boot.patch"
	epatch "${FILESDIR}/0001-Allow-disabling-use-of-namespacing-features-via-env-.patch"

	# Fix Tup respect for similar
	sed -i Tuprules.tup \
		-e "s:CC = gcc:CC = $(tc-getCC) ${CFLAGS} ${LDFLAGS}:" \
		-e "s:ar crs:$(tc-getAR) crs:"
}

src_configure () {
	use system-sqlite && echo "CONFIG_TUP_USE_SYSTEM_SQLITE=y" >> tup.config
}

src_compile() {
	# bootstrap.sh does an initial build of tup using a manual
	# script, then runs tup to rebuild it using itself. tup uses
	# fuse when tracking dependencies.
	addwrite /dev/fuse

	TUP_NO_NAMESPACING=1 ./bootstrap.sh
}

src_install() {
	dobin tup
	dolib.a libtup.a libtup_client.a
	doman tup.1

	use doc && dohtml -r docs
	use suid && fperms 4711 /usr/bin/tup
}

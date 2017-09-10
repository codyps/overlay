# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Script for managing ZFS snapshot replication"
HOMEPAGE="https://github.com/allanjude/zxfer"

if [[ $PV = 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/allanjude/zxfer"
else
	SRC_URI="https://github.com/allanjude/zxfer/archive/${PV}.tar.gz"
fi

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_install() {
	dobin zxfer
	doman zxfer.8
}

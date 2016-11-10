# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=4

inherit cmake-utils multilib

if [ "${PV}" -eq 9999 ]; then
	inherit git-2
	EGIT_REPO_URI="https://github.com/SimonKagstrom/kcov.git"
else
	SRC_URI="https://github.com/SimonKagstrom/kcov/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="A code coverage tester for compiled languages, Python and Bash."
HOMEPAGE="https://simonkagstrom.github.io/kcov/"

LICENSE="GPL-2"
SLOT="0"
IUSE=""

RDEPEND="sys-devel/binutils \
	dev-libs/elfutils \
	sys-libs/zlib \
	net-misc/curl"
DEPEND="${RDEPEND}"

DOCS=( README.md )

src_configure() {
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
}

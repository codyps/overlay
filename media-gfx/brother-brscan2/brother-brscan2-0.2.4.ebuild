# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit rpm

KEYWORDS="~amd64 ~x86"
DESCRIPTION="Brother brscan2 scanner driver."
HOMEPAGE="http://solutions.brother.com/linux/en_us/index.html"
SRC_URI="amd64? ( http://solutions.brother.com/Library/sol/printer/linux/rpmfiles/sane_others/64bit/brscan2-${PV}-0.x86_64.rpm )
		 x86? ( http://solutions.brother.com/Library/sol/printer/linux/rpmfiles/sane_others/brscan2-${PV}-0.i386.rpm )"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND=">=media-gfx/sane-backends-1.0.19"

src_unpack() {
	rpm_src_unpack
}

src_compile() {
	echo "Nothing to compile."
}

src_install() {
	cp -Rf "./" "${D}/"
}

pkg_postinst() {
	${ROOT}usr/local/Brother/sane/setupSaneScan2 -i
}

# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="5"

inherit versionator rpm

DESCRIPTION="Brother Brscan2 scan key tool"
HOMEPAGE="http://welcome.solutions.brother.com/bsc/public_s/id/linux/en/download_scn.html#brscan2"
MY_PV="$(replace_version_separator 3 -)"
SRC_URI="
	amd64? ( http://www.brother.com/pub/bsc/linux/dlf/$PN-${MY_PV}.x86_64.rpm )
	x86? ( http://www.brother.com/pub/bsc/linux/dlf/$PN-${MY_PV}.i386.rpm )
"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}"

src_unpack() {
	rpm_unpack ${A} || die
}

src_install() {
	cp -r opt "${D}" || die
}

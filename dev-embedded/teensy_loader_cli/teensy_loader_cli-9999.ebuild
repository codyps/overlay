# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

DESCRIPTION="Command line Teensy Loader"
HOMEPAGE="http://www.pjrc.com/teensy/loader_cli.html"

inherit git-r3
EGIT_REPO_URI="https://github.com/PaulStoffregen/teensy_loader_cli.git"
if [ "${PV}" != 9999 ]; then
	EGIT_COMMIT="97c4ce06eea5170e1c828302e24d23142cbd9a0c"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE=""

DEPEND="virtual/libusb:1"
RDEPEND="${DEPEND}"

src_install() {
	dobin teensy_loader_cli
}

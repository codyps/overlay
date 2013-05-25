# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header $

EAPI=4

EGIT_REPO_URI=" https://github.com/utzig/lm4tools.git"

inherit eutils git-2

DESCRIPTION="provides lm4flash and lmicdiusb for developing on the TI Stellaris Launchpad"
HOMEPAGE="https://github.com/utzig/lm4tools"

LICENSE="GPL-2+ MIT"
SLOT="0"
IUSE=""

# Common to both DEPEND and RDEPEND
CDEPEND="virtual/libusb:1"
RDEPEND="${CDEPEND}"
DEPEND="${CDEPEND}"

src_compile () {
	emake -C lm4flash
	emake -C lmicdiusb
}

src_install () {
	dobin lm4flash/lm4flash
	dobin lmicdiusb/lmicdiusb
	dodoc README.md lmicdiusb/README
}

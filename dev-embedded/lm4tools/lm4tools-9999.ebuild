# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header $

EAPI=4

EGIT_REPO_URI=" https://github.com/utzig/lm4tools.git"

inherit eutils toolchain-funcs git-2

DESCRIPTION="provides lm4flash and lmicdiusb for developing on the TI Stellaris Launchpad"
HOMEPAGE="https://github.com/utzig/lm4tools"

LICENSE="GPL-2+ MIT"
SLOT="0"
IUSE=""

RDEPEND="virtual/libusb:1"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare () {
	sed -e "s:gcc:$(tc-getCC):" -i lm4flash/Makefile || die
}

src_compile () {
	CC=$(tc-getCC) emake -C lmicdiusb
	emake -C lm4flash
}

src_install () {
	dobin lm4flash/lm4flash
	dobin lmicdiusb/lmicdiusb
	dodoc README.md lmicdiusb/{README,commands.txt}
}

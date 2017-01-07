# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header $

EAPI=4

inherit eutils
if [ ${PV} = 9999 ]; then
	inherit git-2
	EGIT_REPO_URI="git://git.code.sf.net/p/{PN}/code"
	KEYWORDS=""
else
	#SRC_URI="http://sigrok.org/download/source/${PN}/${P}.tar.gz"
	#KEYWORDS="~amd64"
	:
fi

DESCRIPTION="minimize and compress /proc/vmcore for use with crash"
HOMEPAGE="http://sourceforge.net/projects/makedumpfile/"

LICENSE="GPL-2+"
SLOT="0"
IUSE="lzo
	snappy
	static"

RDEPEND="dev-libs/elfutils
	lzo? ( dev-libs/lzo )
	snappy? ( app-arch/snappy )"
DEPEND="${RDEPEND}"

#src_prepare () {
#	sed -e "s:gcc:$(tc-getCC):" -i lm4flash/Makefile || die
#}

src_compile () {
	emake CC=$(tc-getCC) LINKTYPE=dynamic CFLAGS_ARCH=$(CFLAGS)
}

#src_install () {
#	emake install
#}

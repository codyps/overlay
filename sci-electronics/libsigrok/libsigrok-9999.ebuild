# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils git-2 autotools

DESCRIPTION="Library which provides the basic hardware access drivers for logic analyzers, as
well as input/output file format support."
HOMEPAGE="http://sigrok.org/wiki/"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

EGIT_REPO_URI="git://sigrok.git.sourceforge.net/gitroot/sigrok/sigrok"

src_prepare() {
	cd "${PN}"
	eautoreconf
}

src_install() {
	cd "${PN}"
	emake DESTDIR="${D}" install || die "Install failed"
}

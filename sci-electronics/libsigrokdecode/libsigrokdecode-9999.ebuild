# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils git-2 autotools

DESCRIPTION="Library which provides (streaming) protocol decoding functionality."
HOMEPAGE="http://sigrok.org/"
SRC_URI=""
EGIT_REPO_URI="git://sigrok.org/libsigrokdecode"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

# >=pkg-config-0.22
# >=automake-1.11
DEPEND=">=dev-libs/glib-2.24.0
	>=dev-lang/python-3"
RDEPEND="${DEPEND}"

src_prepare() {
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"
}

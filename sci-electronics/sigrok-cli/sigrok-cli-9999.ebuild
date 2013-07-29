# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils git-2 autotools

DESCRIPTION="Command-line client for the sigrok logic analyzer software"
HOMEPAGE="http://sigrok.org/"
SRC_URI=""
EGIT_REPO_URI="git://sigrok.org/sigrok-cli"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="decode"

# >=automake-1.11
# >=autoconf-2.63
# >=pkg-config-0.22
DEPEND=">=sci-electronics/libsigrok-0.2.0
	decode? ( >=sci-electronics/libsigrokdecode-0.2.0 )
	>=dev-libs/glib-2.28.0"
RDEPEND="${DEPEND}"

src_prepare() {
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"
}

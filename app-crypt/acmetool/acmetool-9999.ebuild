# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$
EAPI=5
inherit eutils

DESCRIPTION="command line tool for automatically acquiring certificates from ACME servers"
HOMEPAGE="https://github.com/hlandau/acme"
if [ "${PV}" = 9999 ]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/hlandau/acme.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/hlandau/acme/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="MIT"
SLOT="0"
IUSE="doc"

DEPEND="dev-lang/go"
RDEPEND="${DEPEND}"

#src_prepare() {
#}

#src_configure () {
#}

#src_compile() {
#}

src_install() {
	emake DESTDIR="${D}" install
	use doc && dodoc -r _doc
}

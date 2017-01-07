# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Automatic wireless client penetration"
HOMEPAGE="http://www.remote-exploit.org/articles/misc_research__amp_code/index.html"
SRC_URI="http://www.remote-exploit.org/content/hotspotter-0.4.tar.gz"
LICENSE="GPL-2"
DEPEND=""
SLOT="0"
KEYWORDS="~amd64 ~x86 ~ppc"
IUSE=""
RDEPEND=""

S=${WORKDIR}/${P}/src

src_install() {
	dobin hotspotter
}

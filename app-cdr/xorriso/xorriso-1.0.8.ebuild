# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="ISO 9660 Rock Ridge Filesystem Manipulator"
HOMEPAGE="http://scdbackup.sourceforge.net/xorriso_eng.html"

LICENSE="GPL-3"
SLOT="0"

# Others might be supported, but I am not 100% sure, so I am omitting them.
KEYWORDS="~amd64"

IUSE="acl bzip2 readline zlib"
DEPEND="acl? ( virtual/acl )
		bzip2? ( app-arch/bzip2 )
		zlib? ( sys-libs/zlib )
		readline? ( sys-libs/readline )"
RDEPEND="${DEPEND}"

SRC_URI="http://www.gnu.org/software/xorriso/${P}.tar.gz"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}
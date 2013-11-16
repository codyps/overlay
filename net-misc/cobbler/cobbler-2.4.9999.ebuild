# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit python-r1 webapp

if [[ ${PV} = *9999* ]]; then
	EGIT_REPO_URI="https://github.com/${PN}/${PN}.git"
	inherit git-2
	KEYWORDS=""
else
	# XXX: unknown, fill in
	SRC_URI=""
	KEYWORDS="~amd64"
fi

DESCRIPTION="a Linux installation server that allows for rapid setup of network installation environments"
HOMEPAGE="www.cobblerd.org"

LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

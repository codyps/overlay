# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="Change screen backlight level based on hotkey presses"
HOMEPAGE="https://github.com/jmesmon/illum/"
if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/jmesmon/illum/"
	KEYWORDS=""
else
	SRC_URI="https://github.com/jmesmon/illum/archive/v${PV}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="AGPL-3"
SLOT="0"
IUSE="-systemd"

CDEPEND="dev-libs/libev
	dev-libs/libevdev"
DEPEND="${CDEPEND}
	dev-util/ninja
	virtual/pkgconfig"
RDEPEND="${CDEPEND}"

src_configure() {
	./configure
}

src_compile() {
	ninja
}

src_install() {
	if use systemd; then
		USE_SYSTEMD=true
	else
		USE_SYSTEMD=false
	fi

	DESTDIR="${D}" PREFIX="${EPREFIX}/usr" \
	SYSCONFDIR="${EPREFIX}/etc" \
	RUNSTATEDIR="${EPREFIX}/var/run" \
	USE_SYSTEMD="$USE_SYSTEMD" \
	USE_OPENRC=true \
		./do-install
}

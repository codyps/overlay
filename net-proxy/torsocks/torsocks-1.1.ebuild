# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

DESCRIPTION="allows you to use most socks-friendly applications in a safe way
with Tor. It ensures that DNS requests are handled safely and explicitly rejects
UDP traffic from the application you're using."
HOMEPAGE="http://code.google.com/p/torsocks/"
SRC_URI="http://torsocks.google.com/files/${P}.tar.gz"

LICENSE="GPLv2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+tordns +envconf -socksdns -hostnames"

DEPEND=""
RDEPEND="${DEPEND}"


src_configure() {
	econf \
		--libdir=${EPREFIX}/$(get_libdir)
		$(use_enable tordns) \
		$(use_enable socksdns) \
		$(use_enable envconf) \
		$(use_enable hostnames) || die "configure failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	dobin usewithtor
	dobin torsocks

	dodoc README*
	dodoc doc/*
}

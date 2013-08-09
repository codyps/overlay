# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit libtool multilib eutils

DESCRIPTION="The Audio Output library"
HOMEPAGE="http://www.xiph.org/ao/"

LICENSE="GPL-2"
SLOT="0"
IUSE="alsa nas mmap pulseaudio static-libs"

if [ $PV = 9999 ]; then
	KEYWORDS=""
	ESVN_REPO_URI="http://svn.xiph.org/trunk/ao"
	inherit subversion autotools
else
	KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sh sparc x86 ~x86-fbsd ~x86-interix ~amd64-linux ~ppc-macos ~x64-macos ~x86-macos ~x86-solaris"
	SRC_URI="http://downloads.xiph.org/releases/ao/${P}.tar.gz"
fi

RDEPEND="alsa? ( media-libs/alsa-lib )
	nas? ( media-libs/nas )
	pulseaudio? ( media-sound/pulseaudio )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	if [ $PV = 9999 ]; then
		eautoreconf
	fi
	sed -i -e 's:-O20::' configure || die
	sed -i -e "s:/lib:/$(get_libdir):g" ao.m4 || die
	elibtoolize
}

src_configure() {
	econf \
		$(use_enable static-libs static) \
		--disable-esd \
		$(use_enable alsa alsa) \
		$(use_enable mmap alsa-mmap) \
		--disable-arts \
		$(use_enable nas) \
		$(use_enable pulseaudio pulse)
}

src_install() {
	emake DESTDIR="${D}" docdir="${EPREFIX}/usr/share/doc/${PF}/html" install
	dodoc AUTHORS CHANGES README TODO
	prune_libtool_files --all
}

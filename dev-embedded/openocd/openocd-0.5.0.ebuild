# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/openocd/openocd-0.5.0.ebuild,v 1.4 2011/11/15 21:12:38 vapier Exp $

EAPI="4"

inherit eutils
if [[ ${PV} == "9999" ]] ; then
	inherit autotools git-2
	KEYWORDS=""
	EGIT_REPO_URI="git://${PN}.git.sourceforge.net/gitroot/${PN}/${PN}"
else
	KEYWORDS="~amd64 ~x86"
	SRC_URI="mirror://sourceforge/project/${PN}/${PN}/${PV}/${P}.tar.bz2"
fi

DESCRIPTION="OpenOCD - Open On-Chip Debugger"
HOMEPAGE="http://openocd.sourceforge.net"

LICENSE="GPL-2"
SLOT="0"
IUSE="blaster dummy bindist ft2232 ftd2xx libftdi minidriver parport presto segger usb versaloon"
RESTRICT="strip" # includes non-native binaries

# libftd2xx is the default because it is reported to work better.
DEPEND="dev-lang/jimtcl
	usb?     ( dev-libs/libusb )
	ftd2xx?  ( dev-embedded/libftd2xx )
	libftdi? ( dev-embedded/libftdi )"
RDEPEND="${DEPEND}"

REQUIRED_USE="bindist? ( !ftd2xx )
	ft2232? ( || ( libftdi ftd2xx ) )
	ftd2xx?  ( !libftdi )
	presto?  ( ft2232 )
	blaster? ( ft2232 )"

src_prepare() {
	if [[ ${PV} == "9999" ]] ; then
		sed -i -e "/@include version.texi/d" doc/${PN}.texi || die
		AT_NO_RECURSIVE=yes eautoreconf
	fi
}

src_configure() {
	# Here are some defaults
	myconf="--enable-buspirate --enable-ioutil --disable-werror
	--disable-internal-jimtcl --enable-amtjtagaccel
	--enable-ep93xx --enable-at91rm9200 --enable-gw16012
	--enable-oocd_trace"

	if use usb; then
		myconf="${myconf} --enable-usbprog --enable-jlink --enable-rlink \
			--enable-vsllink --enable-arm-jtag-ew"
	fi

	# add explicitely the path to libftd2xx
	use ftd2xx && LDFLAGS="${LDFLAGS} -L/opt/$(get_libdir)"

	if use blaster; then
		use libftdi && myconf="${myconf} --enable-usb_blaster_libftdi"
		use ftd2xx  && myconf="${myconf} --enable-usb_blaster_ftd2xx"
	fi
	if use presto; then
		use libftdi && myconf="${myconf} --enable-presto_libftdi"
		use ftd2xx  && myconf="${myconf} --enable-presto_ftd2xx"
	fi

	econf \
		$(use_enable dummy) \
		$(use_enable libftdi ft2232_libftdi) \
		$(use_enable ftd2xx  ft2232_ftd2xx) \
		$(use_enable minidriver minidriver-dummy) \
		$(use_enable parport) \
		$(use_enable segger jlink) \
		$(use_enable versaloon vsllink) \
		${myconf}
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README TODO || die
	prepstrip "${D}"/usr/bin
}
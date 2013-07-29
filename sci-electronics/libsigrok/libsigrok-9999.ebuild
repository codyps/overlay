# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils git-2 autotools

DESCRIPTION="Library which provides the basic hardware access drivers for logic analyzers, as
well as input/output file format support."
HOMEPAGE="http://sigrok.org/"

SRC_URI=""
EGIT_REPO_URI="git://sigrok.org/libsigrok"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="udev alsa usb ftdi"

# libusb >= 1.0.9
DEPEND=">=dev-libs/glib-2.32.0
	>=dev-libs/libzip-0.8
	>=dev-libs/check-0.9.4
	usb?  ( virtual/libusb:1 )
	ftdi? ( >=dev-embedded/libftdi-0.16 )
	alsa? ( >=media-libs/alsa-lib-1.0 )
	udev? ( >=virtual/udev-151 )"
RDEPEND="${DEPEND}"

src_prepare() {
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"
}

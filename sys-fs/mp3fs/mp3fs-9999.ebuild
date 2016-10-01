# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

DESCRIPTION="a read-only FUSE filesystem which transcodes FLAC audio files to MP3 when read"
HOMEPAGE="https://khenriks.github.com/mp3fs/"
LICENSE="GPL-3"
SLOT="0"

if [[ "${PV}" == 9999 ]]; then
	inherit git-r3 autotools
	EGIT_REPO_URI="https://github.com/khenriks/mp3fs.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/khenriks/mp3fs/releases/download/v${PV}/${P}.tar.gz"
	KEYWORDS="amd64 x86"
fi


DEPEND="sys-fs/fuse
	media-libs/libid3tag
	media-libs/flac
	media-sound/lame
	media-libs/libogg"
RDEPEND="${DEPEND}"

src_prepare() {
	if [[ "${PV}" == 9999 ]]; then
		eautoreconf
	fi
	default_src_prepare
}

src_configure() {
	# Avoid failure due to undefined "BUFFERSIZE"
	econf --without-vorbis-picture
}

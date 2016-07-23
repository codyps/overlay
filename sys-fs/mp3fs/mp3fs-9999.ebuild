# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

DESCRIPTION="a read-only FUSE filesystem which transcodes FLAC audio files to MP3 when read"
HOMEPAGE="https://khenriks.github.com/mp3fs/"

if [[ "${PV}" == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/khenriks/mp3fs.git"
else
	KEYWORDS="amd64 x86"
	SRC_URI="https://github.com/khenriks/mp3fs/releases/download/v${PV}/${P}.tar.gz"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE=""

DEPEND="sys-fs/fuse
	media-libs/libid3tag
	media-libs/flac
	media-sound/lame
	media-libs/libogg"
RDEPEND="${DEPEND}"

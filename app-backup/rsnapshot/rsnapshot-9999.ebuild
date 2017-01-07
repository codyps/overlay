# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

EGIT_REPO_URI="git://git.github.com/jmesmon/rsnapshot.git"

inherit eutils git-2

DESCRIPTION="A filesystem backup utility based on rsync"
HOMEPAGE="http://www.rsnapshot.org"

SRC_URI=""

SLOT="0"
LICENSE="GPL-2"

[[ $PV = *9999* ]] && KEYWORDS="" || KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND=">=dev-lang/perl-5.8.2
		>=sys-apps/util-linux-2.12-r4
		>=sys-apps/coreutils-5.0.91-r4
		>=net-misc/openssh-3.7.1_p2-r1
		>=net-misc/rsync-2.6.0"
DEPEND="${RDEPEND}"

src_install() {
	# Change sysconfdir to install the template file as documentation
	# rather than in /etc.
	emake install DESTDIR="${D}" \
		sysconfdir="/usr/share/doc/${PF}" \
		|| die

	dodoc README AUTHORS TODO ChangeLog \
		docs/Upgrading_from_1.1 \
		docs/HOWTOs/rsnapshot-{Mac,windows}-howto

	docinto utils
	dodoc utils/{README,rsnaptar,*.sh,*.pl}

	docinto utils/rsnapshotdb
	dodoc utils/rsnapshotdb/*
}

pkg_postinst() {
	elog "The template configuration file has been installed as"
	elog "/usr/share/doc/${PF}/rsnapshot.conf.default"
	elog "Copy and edit the the above file as /etc/rsnapshot.conf"
}

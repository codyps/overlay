# Copyright 2010-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6
inherit autotools
inherit bash-completion-r1 user systemd

DESCRIPTION="Bitcoin Unlimited crypto-currency wallet for automated services"
HOMEPAGE="https://www.bitcoinunlimited.info/"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~mips ~ppc ~x86 ~amd64-linux ~x86-linux"
PN_BASE="bitcoin"

IUSE="qt4 qt5 upnp +daemon +wallet qrcode +utils +zeromq static-libs examples logrotate"
RDEPENDS="\
	upnp? (net-libs/miniupnpc) \
	qrcode? (media-gfx/qrencode) \
	|| ( \
		qt5 ? (dev-qt/qtgui:5 dev-qt/linguist-tools) \
		qt4 ? (dev-qt/qtgui:4 >dev-qt/qt-meta-4) \
	) \
	wallet? (sys-libs/db:4.8[cxx]) \
"
DEPENDS="${RDEPENDS}"

REQUIRED_USE="logrotate? ( daemon ) qrcode? ( || ( qt4 qt5 ) )"

SRC_URI="https://github.com/BitcoinUnlimited/BitcoinUnlimited/archive/bu${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/BitcoinUnlimited-bu${PV}"

pkg_setup() {
	local UG='bitcoin'
	enewgroup "${UG}"
	enewuser "${UG}" -1 -1 /var/lib/bitcoin "${UG}"
}

src_prepare() {
	default
	eautoreconf
	#sed -i 's/have bitcoind &&//;s/^\(complete -F _bitcoind bitcoind\) bitcoin-cli$/\1/' contrib/${PN}.bash-completion || die
}

src_configure() {
	gui=
	if use qt5; then
		gui=qt5
	elif use qt4; then
		gui=qt4
	else
		gui=no
	fi

	econf \
		--disable-bench  \
		--disable-ccache \
		--with-gui=$gui \
		$(use_with upnp miniupnpc) \
		$(use_with qrcode qrencode) \
		$(use_with daemon) \
		$(use_with utils) \
		$(use_enable zeromq zmq) \
		$(use_enable static-libs static) \
		$(use_enable wallet)
}

src_install() {
	default

	insinto /etc/bitcoin
	newins "${FILESDIR}/bitcoin.conf" ${PN_BASE}.conf
	fowners bitcoin:bitcoin /etc/bitcoin/${PN_BASE}.conf
	fperms 600 /etc/bitcoin/${PN_BASE}.conf

	newconfd "contrib/init/bitcoind.openrcconf" ${PN}
	newinitd "contrib/init/bitcoind.openrc" ${PN}
	cp "${FILESDIR}/bitcoind.service" "${WORKDIR}/${PN}.service"
	systemd_dounit "${WORKDIR}/${PN}.service"

	keepdir /var/lib/bitcoin/.bitcoin
	fperms 700 /var/lib/bitcoin
	fowners bitcoin:bitcoin /var/lib/bitcoin/
	fowners bitcoin:bitcoin /var/lib/bitcoin/.bitcoin
	dosym /etc/bitcoin/${PN_BASE}.conf /var/lib/bitcoin/.bitcoin/bitcoin.conf

	dodoc doc/assets-attribution.md doc/bips.md doc/tor.md
	doman contrib/debian/manpages/{bitcoind.1,bitcoin.conf.5}

	use zeromq && dodoc doc/zmq.md

	newbashcomp contrib/bitcoind.bash-completion ${PN}

	if use examples; then
		docinto examples
		dodoc -r contrib/{qos,spendfrom,tidy_datadir.sh}
		use zeromq && dodoc -r contrib/zmq
	fi

	if use logrotate; then
		insinto /etc/logrotate.d
		newins "${FILESDIR}/bitcoind.logrotate-r1" ${PN}
	fi
}

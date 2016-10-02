# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$
EAPI=6

GOLANG_PKG_IMPORTPATH="github.com/hlandau"
GOLANG_PKG_BUILDPATH="/cmd/acmetool"
GOLANG_PKG_ARCHIVEPREFIX="v"
GOLANG_PKG_NAME="acme"
GOLANG_PKG_USE_CGO=1

GOLANG_PKG_DEPENDENCIES=(
	"github.com/coreos/go-systemd:b4a58d9" # v4
	"github.com/hlandau/xlog:197ef798aed28e08ed3e176e678fda81be993a31"
	"github.com/hlandau/goutils:0cdb66aea5b843822af6fdffc21286b8fe8379c4"
	"github.com/mitchellh/go-wordwrap:ad45545899c7b13c020ea92b2072220eefad42b8"
	"github.com/peterhellberg/link"
	"github.com/jmhodges/clock"
	"github.com/hlandau/dexlogconfig"
	"github.com/satori/go.uuid"
	"golang.org/x/crypto"
	"golang.org/x/net"
	"gopkg.in/yaml.v2"
	"gopkg.in/tylerb/graceful.v1"
	"gopkg.in/hlandau/svcutils.v1"
	"gopkg.in/hlandau/service.v2"
)

DESCRIPTION="command line tool for automatically acquiring certificates from ACME servers"
HOMEPAGE="https://github.com/hlandau/acme"
if [ "${PV}" = 9999 ]; then
	inherit golang-live
	KEYWORDS=""
else
	inherit golang-single
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="MIT"
SLOT="0"
IUSE="doc"

DEPEND="dev-lang/go sys-libs/libcap"
RDEPEND="${DEPEND}"

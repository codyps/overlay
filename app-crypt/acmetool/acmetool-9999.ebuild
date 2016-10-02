# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$
EAPI=6

GOLANG_PKG_IMPORTPATH="github.com/hlandau"
GOLANG_PKG_BUILDPATH="/cmd/acmetool"
GOLANG_PKG_ARCHIVEPREFIX="v"
GOLANG_PKG_NAME="acme"
GOLANG_PKG_USE_CGO=1

DESCRIPTION="command line tool for automatically acquiring certificates from ACME servers"
HOMEPAGE="https://github.com/hlandau/acme"
if [ "${PV}" = 9999 ]; then
	inherit golang-live
	KEYWORDS=""
else
	GOLANG_PKG_DEPENDENCIES=(
		"github.com/coreos/go-systemd:b4a58d9" # v4
		"github.com/hlandau/xlog:197ef798aed28e08ed3e176e678fda81be993a31"
		"github.com/hlandau/goutils:0cdb66aea5b843822af6fdffc21286b8fe8379c4"
		"github.com/mitchellh/go-wordwrap:ad45545899c7b13c020ea92b2072220eefad42b8"
		"github.com/peterhellberg/link:d1cebc7ea14a5fc0de7cb4a45acae773161642c6" #v1.0.0
		"github.com/jmhodges/clock:880ee4c335489bc78d01e4d0a254ae880734bc15"
		"github.com/hlandau/dexlogconfig:055e2e35f21ef605ada9e9af4e36597678678bf1"
		"github.com/satori/go.uuid:b061729afc07e77a8aa4fad0a2fd840958f1942a"
		"github.com/golang/crypto:568507f56e5b05b3c219ffd7fba12655c07bcc86 -> golang.org/x"
		"github.com/golang/net:cd95c68ba21fc7ee16ee38cc420473e3d8c4afd8    -> golang.org/x"
		"github.com/go-yaml/yaml:a5b47d31c556af34a302ce5d659e6fea44d90de0  -> gopkg.in/yaml.v2"
		"github.com/tylerb/graceful:48afeb2 -> gopkg.in/tylerb/graceful.v1" #v1.2.3
		"github.com/hlandau/svcutils:c25dac49e50cbbcbef8c81b089f56156f4067 -> gopkg.in/hlandau/svcutils.v1"
		"github.com/hlandau/service:601cce2a79c1e61856e27f43c28ed4d7d2c7a619 -> gopkg.in/hlandau/service.v2" #v2.0.15
	)
	inherit golang-single
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="MIT"
SLOT="0"
IUSE="doc"

DEPEND="dev-lang/go sys-libs/libcap"
RDEPEND="${DEPEND}"

# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"
PYTHON_COMPAT=(python{2_7,3_4,3_5,3_6,3_7})
inherit bash-completion-r1 distutils-r1 git-r3 readme.gentoo-r1

DESCRIPTION="Youtube Upload videos from YouTube.com (and more sites...)"
HOMEPAGE="https://github.com/tokland/youtube-upload/"
EGIT_REPO_URI="https://github.com/tokland/youtube-upload/"
LICENSE="GPL-3"

KEYWORDS=""
RESTRICT="test"
SLOT="0"
RDEPEND="
	dev-python/google-api-python-client[${PYTHON_USEDEP}]
	dev-python/oauth2client[${PYTHON_USEDEP}]
"
DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
"

src_compile() {
	distutils-r1_src_compile
}

python_install_all() {
	dodoc README.md

	distutils-r1_python_install_all
}

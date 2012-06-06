EAPI=3
inherit git eutils

EGIT_REPO_URI="git://github.com/pavouk/lgi.git"

DESCRIPTION="Lua binding to GObject based libraries."
HOMEPAGE="https://github.com/pavouk/lgi"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND=">=dev-lang/lua-5.1"

src_unpack()
{
	git_src_unpack
	echo -n "`git --git-dir="${GIT_DIR}" describe`-gentoo" > ${S}/.version_stamp
}

src_compile()
{
	emake || die
}

src_install()
{
	emake install	\
		DESTDIR="${D}"	\
		INSTALL_TOP_SHARE="${D}/$(pkg-config --variable INSTALL_LMOD lua)"	\
		INSTALL_TOP_LIB="${D}/$(pkg-config --variable INSTALL_CMOD lua | sed -e "s:lib/:$(ged_libdir)/:")"	\
		|| die
}

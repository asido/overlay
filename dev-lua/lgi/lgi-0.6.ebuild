EAPI=3
inherit eutils

DESCRIPTION="Lua binding to GObject based libraries."
HOMEPAGE="https://github.com/pavouk/lgi"
SRC_URI="https://github.com/downloads/pavouk/lgi/lgi-0.6.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND=">=dev-lang/lua-5.1"

src_prepare()
{
	sed -i "s:^LUA_LIBDIR.*$:LUA_LIBDIR = $(pkg-config --variable INSTALL_CMOD lua):" \
		"${S}/lgi/Makefile" || die "LUA_LIBDIR sed failed"
	sed -i	\
		"s:^LUA_SHAREDIR.*$:LUA_SHAREDIR = $(pkg-config --variable INSTALL_LMOD lua):" \
		"${S}/lgi/Makefile" || die "LUA_SHAREDIR sed failed"
	emake || die
}

src_install()
{
	emake	\
		DESTDIR="${D}"	\
		install || die
}

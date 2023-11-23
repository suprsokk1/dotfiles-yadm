version		= emacs-29.1
repo		= git://git.savannah.gnu.org/emacs.git
deps		= git libgccjit libgccjit-devel dnf-plugins-core
configure	= --with-native-compilation
configure  += --with-json
configure  += --with-pgtk

MAKEOPTS = -j9

sources:
	git clone --branch ${version} --depth 1 ${repo}

build: emacs/autogen.sh emacs/configure

emacs/autogen.sh emacs/configure:
	./$@ $(call $@)

deps:
	dnf -y $(call $@)
	dnf -y builddep emacs

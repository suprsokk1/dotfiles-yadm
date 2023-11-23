##
# download nerdfonts
#

version = v3.0.2
prefix = github.com/ryanoasis/nerd-fonts/releases/download/${version}
deps = pup
pup = go install github.com/ericchiang/pup@main
dir = ~/.local/share/fonts
site_url = nerdfonts.com/downloads

define unzip
mkdir -p fonts/
unzip -C $@ "*.[ot]tf"  -d fonts/
endef

all:
	@echo Type 'make install'

install: $(shell awk -F/ '{print $$NF}' nerdfonts) nerdfonts


nerdfonts: ${deps}
	curl --fail -L --output - --silent -- ${site_url} | ~/go/bin/pup 'a[href*="zip"]:contains("Download")' attr{href} > $@
	grep --count . $@

%.ttf %.otf: symlink

%.zip:
	curl -L --fail --remote-name https://${prefix}/$@

fonts:
	ln -sfrv ${dir} $@

${deps}:
	command -v $@ || $(call $@)
	touch $@

# end

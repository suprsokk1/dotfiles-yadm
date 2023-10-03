##
# download nerdfonts
#

version = v3.0.2
prefix = github.com/ryanoasis/nerd-fonts/releases/download/${version}
deps = pup
pup = go install github.com/ericchiang/pup@main
dir = ~/.local/share/fonts

all:
	@echo Type 'make install'

install: $(shell awk -F/ '{print $$NF}' nerdfonts) nerdfonts
	yes 'n' | unzip -C $(wildcard *.zip) "*.[ot]tf"  -d ${dir}

nerdfonts: ${deps}
	curl --fail -L --output - --silent -- nerdfonts.com/downloads | pup 'a[href*="zip"]:contains("Download")' attr{href} > $@
	grep --count . $@

%.zip:
	curl -L --fail --remote-name https://${prefix}/$@

${deps}:
	command -v $@ || $(call $@)
	touch $@

# end

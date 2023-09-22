help:
	@ echo TODO

test:
	@ echo TODO

install:
	ansible-playbook ansible-playbook.yml

fonts: nerdfonts

nerdfonts: ${HOME}/Downloads
	curl --output-file gg --silent -- nerdfonts.com/downloads
	pup 'a[href*="zip"]:contains("Download")' attr{href} < gg > ggg
	xargs -a gg env -C $^ curl --retry 2 --verbose --remote-name  --progress-bar

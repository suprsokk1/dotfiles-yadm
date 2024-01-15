# ~/.config/yadm/src/ansible-playbook/Makefile

install: community.general geerlingguy.pip
	ansible-playbook local.yml

community.general:
	-ansible-galaxy collection install $@

geerlingguy.pip:
	-ansible-galaxy role install $@

.PHONY: ~/.config/yadm/src/ansible-playbook/requirements.yml geerlingguy.pip community.general

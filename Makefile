HOME_CONFIGS   = home
NIXOS_CONFIGS  = nixos
GPG_CONFIGS    = gpg
BIN_CONFIGS    = bin
HOME_TARGET    = $(HOME)
NIXOS_TARGET   = /etc/nixos
GPG_TARGET     = $(HOME)/.gnupg
BIN_TARGET     = /usr/local/bin

all: help

help:
	@echo "Dotfiles makefile usage:"
	@echo "  home  - Install user configs to ~/"
	@echo "  nixos - Install NixOS configs to /etc/nixos"
	@echo "  gpg   - Install gpg configs to /.gnupg"
	@echo "  bin   - Install Bin's sctipts to /usr/local/bin"
	@echo ""
	@echo "  unhome  - Uninstall user configs"
	@echo "  unnixos - Uninstall NixOS configs"
	@echo "  ungpg     - Uninstall gpg configs"
	@echo "  unbin   - Uninstall Bin's sctipts"

home:
	mkdir -p $(HOME_TARGET)/.config/nvim/
	stow -v -t $(HOME_TARGET) $(HOME_CONFIGS)

unhome:
	stow -D -v -t $(HOME_TARGET) $(HOME_CONFIGS)

nixos:
	sudo stow -v -t $(NIXOS_TARGET) $(NIXOS_CONFIGS)

unnixos:
	sudo stow -D -v -t $(NIXOS_TARGET) $(NIXOS_CONFIGS)

gpg:
	mkdir -p $(GPG_TARGET)
	stow -v -t $(GPG_TARGET) $(GPG_CONFIGS)

ungpg:
	stow -D -v -t $(GPG_TARGET) $(GPG_CONFIGS)

bin:
	sudo mkdir -p /usr/local/bin/
	sudo stow -v -t $(BIN_TARGET) $(BIN_CONFIGS)

unbin:
	sudo stow -Dv -t $(BIN_TARGET) $(BIN_CONFIGS)

.PHONY: all help home unhome nixos unnixos bin unbin gpg ungpg

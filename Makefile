HOME_CONFIGS   = home
ARCH_CONFIGS   = arch
NIXOS_CONFIGS  = nixos
HOME_TARGET    = $(HOME)
NIXOS_TARGET   = /etc/nixos
ARCH_TARGET    = /etc

all: help

help:
	@echo "Dotfiles makefile usage:"
	@echo "  home   - Install user configs to ~/"
	@echo "  arch   - Install Arch configs to /etc"
	@echo "  nixos  - Install NixOS configs to /etc/nixos"
	@echo ""
	@echo "  unhome  - Uninstall user configs"
	@echo "  unarch  - Uninstall Arch configs"
	@echo "  unnixos - Uninstall NixOS configs"

home:
	stow -v -t $(HOME_TARGET) $(HOME_CONFIGS)

unhome:
	stow -D -v -t $(HOME_TARGET) $(HOME_CONFIGS)

arch:
	sudo stow -v -t $(ARCH_TARGET) $(ARCH_CONFIGS)

unarch:
	sudo stow -D -v -t $(ARCH_TARGET) $(ARCH_CONFIGS)

nixos:
	sudo stow -v -t $(NIXOS_TARGET) $(NIXOS_CONFIGS)

unnixos:
	sudo stow -D -v -t $(NIXOS_TARGET) $(NIXOS_CONFIGS)

.PHONY: help home unhome arch unarch nixos unnixos all

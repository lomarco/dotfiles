#!/bin/sh

HOME_CONFIGS=home
ARCH_CONFIGS=os-specific/arch
NIXOS_CONFIGS=os-specific/nixos

err() {
  echo -e "\e[1;31merr:$1\e[0m"
}

home_installer() {
  mkdir -p "$HOME"/.config
  stow -v -t "$HOME" "$HOME_CONFIGS"
}

home_uninstaller() {
  stow -Dv -t "$HOME" "$HOME_CONFIGS"
}

arch_installer() {
  stow -v -t "/etc" "$ARCH_CONFIGS"
}

arch_uninstaller() {
  stow -Dv -t "/etc" "$ARCH_CONFIGS"
}

nixos_installer() {
  stow -v -t "/etc/nixos" "$NIXOS_CONFIGS"
}

nixos_uninstaller() {
  stow -Dv -t "/etc/nixos" "$NIXOS_CONFIGS"
}

print_usage() {
  echo -e "Usage: $0 <options>
  Options:
    -h, --help   Showing this help message
  Arguments:
    home   Install user configs for home dir
    arch   Install system configs for nixos
    nixos  Install system configs for nixos

    unhome  Uninstall user configs for home dir
    unarch  Uninstall system configs for nixos
    unixos  Uninstall system configs for nixos"
}

main() {
  for arg in "$@"; do
    if [[ "$arg" == "home" ]]; then
      home_installer
      exit 0
    elif [[ "$arg" == "arch" ]]; then
      arch_installer
      exit 0
    elif [[ "$arg" == "nixos" ]]; then
      nixos_installer
      exit 0
    elif [[ "$arg" == "unhome" ]]; then
      home_uninstaller
      exit 0
    elif [[ "$arg" == "unarch" ]]; then
      arch_uninstaller
      exit 0
    elif [[ "$arg" == "unnixos" ]]; then
      nixos_uninstaller
      exit 0
    elif [[ "$arg" == "--help" || "$arg" == "-h" ]]; then
      print_usage $0
      exit 0
    else
      err "unknown argument: '$arg'"
      exit 1
  fi
  done
}

main "$@"

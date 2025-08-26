<h1 align="center">Lomarco's Dotfiles</h1>
<img src="docs/1.png" align="1" width="px">

<details open="open">
<summary>Table of Contents</summary>

- [Toolchain](#toolchain)
- [Gallery](#gallery)
- [Repo Guide](#repo-guide)
  - [base](#base)
    - [Sway](#sway)
    - [I3status](#i3status)
    - [Foot](#foot)
    - [Git-config](#gitconfig)
    - [NeoVim](#neovim)
    - [Tmux](#tmux)
    - [Vim](#vimrc)
    - [Zsh](#zshrc)
  - [extra](#extra)
    - [Fstab](#fstab)
    - [Pacman](#pacman)
    - [Iwd](#iwd)
    - [Mkinitcpio](#mkinitcpio)
    - [Paru](#paru)
    - [Kernel](#Kernel)
  - [scr](#scr)
    - [auto\_backup](#auto-backup)
    - [efistub-boot](#efistub-boot)
    - [mir-sync](#mir-sync)
    - [udp](#udp)
    - [udy](#udy)
- [Sway hot keys](#sway-hot-keys)
- [Copyright](#copyright)
</details>

# Toolchain
<div style="text-align: center;">

 - OS: [**`Arch Linux`**](https://archlinux.org/)
 - Kernel: [**`Linux zen`**](https://github.com/zen-kernel/zen-kernel)
 - WM: [**`Sway`**](https://swaywm.org/)
 - Bar: [**`I3status`**](https://github.com/Alexays/Waybar)
 - Terminal: [**`Foot`**](https://codeberg.org/dnkl/foot)
 - Shell: [**`Zsh znap`**](https://github.com/marlonrichert/zsh-snap)
 - Editor: [**`NeoVim`**](https://neovim.io/)
 - Multiplexer: [**`Tmux`**](https://archive.kernel.org/oldwiki/iwd.wiki.kernel.org/)
 - Notify Manager: [**`Mako`**](https://github.com/emersion/mako)
 - AUR Helper: [**`Paru`**](https://github.com/Morganamilo/paru)
 - Password Manager: [**`Pass`**](http://www.passwordstore.org/)
 - Bootloader: [**`Efi Stub`**](https://wiki.archlinux.org/title/EFI_boot_stub)
 - WiFi Manager: [**`Iwd`**](https://archive.kernel.org/oldwiki/iwd.wiki.kernel.org/)
 - File Manager: [**`Lf`**](https://github.com/gokcehan/lf)
</div>

# Gallery
<img src="docs/2.png" align="2" width="px">
<img src="docs/3.png" align="3" width="px">

# Repo Guide
## base
### [Sway](base/config)
### [I3status](base/config_i3status)
### [Foot](base/foot.ini)
### [Git-config](base/gitconfig)
### [NeoVim](base/init.lua)
### [Tmux](base/tmux.conf)
### [Vim](base/vimrc)
### [Zsh](base/zshrc)

## extra
### [Fstab](extra/fstab)
### [Pacman](extra/pacman.conf)
### [Iwd](extra/main.conf)
### [Mkinitcpio](extra/mkinitcpio.conf)
### [Paru](extra/paru.conf)
### [Kernel](extra/kernel_config)

## scr
### [auto\_backup](scr/auto_backup)
### [efistub-boot](scr/efistub-boot)
### [mir-sync](scr/mir-sync)
### [udp](scr/udp)
### [udy](scr/udy)


## Sway HotKeys
| Action                     | Shortcut             |
|----------------------------|---------------------|
| **Open the terminal**       | `super + enter`     |
| **Launch browser**          | `super + shift + b` |
| **Launch wmenu**            | `super + p`         |
| **Take a screenshot**       | `PtrSc`             |
| **Kill window**             | `super + shift + q` |
| **Kill sway**               | `super + shift + e` |
| **Reload sway**             | `super + shift + c` |
| **Moving between workspaces** | `super + {1, 2..0}` |
| **Moving between windows**  | `super + {h, j, k, l}` |
| **Fullscreen window mode**  | `super + f`         |

The other hotkeys are in [sway](config_files/config)

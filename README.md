# Lomarco's Dotfiles

<p align="center">
  <img src="docs/1.png" alt="Lomarco's Dotfiles preview" width="1000" />
</p>

<details open>
  <summary>Contents</summary>

- [Toolchain](#toolchain)
- [Gallery](#gallery)
- [Sway Hotkeys](#sway-hotkeys)
- [NeoVim Config](#Neovim-config)
- [Repository Structure](#repository-structure)
  - [Base](#base)
    - [Sway](#sway)
    - [I3status](#i3status)
    - [Foot](#foot)
    - [Git Config](#git-config)
    - [NeoVim](#neovim)
    - [Tmux](#tmux)
    - [Vim](#vim)
    - [Zsh](#zsh)
  - [Extra](#extra)
    - [Fstab](#fstab)
    - [Pacman](#pacman)
    - [Iwd](#iwd)
    - [Mkinitcpio](#mkinitcpio)
    - [Paru](#paru)
    - [Kernel](#kernel)
    - [Makepkg](#makepkg)
  - [Scripts](#scripts)
    - [auto\_backup](#auto_backup)
    - [efistub-boot](#efistub-boot)
    - [testkernel](#testkernel)
    - [aupa](#aupa)
- [License](#license)

</details>

## Toolchain

<div align="center">

**OS:** `Arch Linux`

**Kernel:** `Linux Zen`

**Window Manager:** `Sway`

**Status Bar:** `Swaybar & I3status`

**Terminal:** `Foot`

**Shell:** `Zsh`

**Editor:** `NeoVim`

**Multiplexer:** `Tmux`

**Notification Manager:** `Mako`

**AUR Helper:** `Paru`

**Password Manager:** `Pass`

**Bootloader:** `EFI Stub`

**WiFi Manager:** `Iwd`

**File Manager:** `Yazi`

**Pdf Reader:** `Zathura`

**Task Manager** `Task Warrior`

</div>

## Gallery

<p align="center">
  <img src="docs/2.png" alt="Gallery image 1" width="1000" />
  <br />
  <img src="docs/3.png" alt="Gallery image 2" width="1000" />
</p>

## Sway Hotkeys

| Action                    | Shortcut            |
|---------------------------|---------------------|
| **Open terminal**         | `Super + Enter`     |
| **Launch browser**        | `Super + Shift + B` |
| **Launch launcher**       | `Super + D`         |
| **Launch obsidian**       | `Super + Shift + Y` |
| **Launch zathura**        | `Super + Shift + Z` |
| **Take screenshot**       | `PrintScreen`       |
| **Take a part of screen** | `Super + C`         |
| **Kill window**           | `Super + Shift + Q` |
| **Exit sway**             | `Super + Shift + E` |
| **Reload sway config**    | `Super + Shift + C` |
| **Switch workspace**      | `Super + {1..0}`    |
| **Focus window**          | `Super + {H, J, K, L}` |
| **Fullscreen window**     | `Super + F`         |

Other hotkeys are available in the [sway config](base/config).

## NeoVim Config
Neovim config is a minimalistic, single-file configuration for programming in C, ASM, and C++, working with Git, and taking notes in Markdown. It includes essential plugins and sensible defaults for a smooth coding workflow.

#### Included Plugins and Modules
- lazy.nvim - plugin manager

- copilot.vim - AI code completion

- telescope.nvim - fuzzy finder for files, buffers, grep

- nvim-treesitter - syntax highlighting and indentation

- nvim-lspconfig - language server protocol support

- nvim-cmp - autocompletion framework

- mason.nvim and mason-lspconfig.nvim - LSP installer and manager

- gitsigns.nvim - git integration and signs

- Comment.nvim - easy code commenting

- mini.tabline - tabline for buffers

- autoclose.nvim - automatic closing of brackets and quotes

- tagbar - code structure sidebar

- oil.nvim - file explorer with git status

Color schemes like kanagawa.nvim and tokyonight.nvim

#### Basic Keybindings
```
<leader>h — toggle integrated terminal window

jk (insert mode) — quickly exit insert mode

Buffer navigation: gn (next), gp (previous), gw (close buffer), ge (open new empty buffer)

Completion navigation with <Tab> and <Shift-Tab> to select suggestions

LSP shortcuts:
    gd — go to definition

    gi — go to implementation

    K — show hover information

    <leader>ca — code actions

    <leader>r — rename symbol

    <leader>e — open diagnostics float

    [d and ]d — jump between diagnostics

    <leader>f — format file
```
## Repository Structure

### Base

- [Sway](base/config)
- [I3status](base/config_i3status)
- [Foot](base/foot.ini)
- [Git config](base/gitconfig)
- [NeoVim](base/init.lua)
- [Tmux](base/tmux.conf)
- [Vim](base/vimrc)
- [Zsh](base/zshrc)

### Extra

- [Fstab](extra/fstab)
- [Pacman](extra/pacman.conf)
- [Iwd](extra/main.conf)
- [Mkinitcpio](extra/mkinitcpio.conf)
- [Paru](extra/paru.conf)
- [Kernel](extra/kernel_config)
- [Makepkg](extra/makepkg.conf)

### Scripts

- [auto\_backup](scr/auto_backup)
- [efistub-boot](scr/efistub-boot)
- [testkernel](scr/testkernel)
- [aupa](scr/aupa)

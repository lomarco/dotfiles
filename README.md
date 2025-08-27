-<h1 align="center">Lomarco's Dotfiles</h1>
-<img src="docs/1.png" align="1" width="px">

<p align="center">
  <img src="docs/1.png" alt="Lomarco's Dotfiles preview" width="600" />
</p>

<details open>
  <summary>Contents</summary>

- [Toolchain](#toolchain)
- [Gallery](#gallery)
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
  - [Scripts](#scripts)
    - [auto_backup](#auto_backup)
    - [efistub-boot](#efistub-boot)
    - [mir-sync](#mir-sync)
    - [udp](#udp)
    - [udy](#udy)
- [Sway Hotkeys](#sway-hotkeys)
- [License](#license)

</details>

---

## Toolchain

<div align="center">

- **OS:** `Arch Linux`  
- **Kernel:** `Linux zen`  
- **Window Manager:** `Sway`  
- **Status Bar:** `I3status`  
- **Terminal:** `Foot`  
- **Shell:** `Zsh + znap`  
- **Editor:** `NeoVim`  
- **Multiplexer:** `Tmux`  
- **Notification Manager:** `Mako`  
- **AUR Helper:** `Paru`  
- **Password Manager:** `Pass`  
- **Bootloader:** `EFI Stub`  
- **WiFi Manager:** `Iwd`  
- **File Manager:** `Lf`

</div>

---

## Gallery

<p align="center">
  <img src="docs/2.png" alt="Gallery image 1" width="600" />
  <br />
  <img src="docs/3.png" alt="Gallery image 2" width="600" />
</p>

---

## Repository Structure

### Base

- [Sway configuration](base/config)  
- [I3status configuration](base/config_i3status)  
- [Foot configuration](base/foot.ini)  
- [Git config](base/gitconfig)  
- [NeoVim config](base/init.lua)  
- [Tmux config](base/tmux.conf)  
- [Vim config](base/vimrc)  
- [Zsh config](base/zshrc)  

### Extra

- [Fstab](extra/fstab)  
- [Pacman config](extra/pacman.conf)  
- [Iwd config](extra/main.conf)  
- [Mkinitcpio config](extra/mkinitcpio.conf)  
- [Paru config](extra/paru.conf)  
- [Kernel config](extra/kernel_config)  

### Scripts

- [auto_backup](scr/auto_backup)  
- [efistub-boot](scr/efistub-boot)  
- [mir-sync](scr/mir-sync)  
- [udp](scr/udp)  
- [udy](scr/udy)  

---

## Sway Hotkeys

| Action                    | Shortcut             |
|---------------------------|---------------------|
| **Open terminal**         | `Super + Enter`     |
| **Launch browser**        | `Super + Shift + B` |
| **Launch launcher (wmenu)** | `Super + P`         |
| **Take screenshot**       | `PrintScreen`       |
| **Kill window**           | `Super + Shift + Q` |
| **Exit sway**             | `Super + Shift + E` |
| **Reload sway config**    | `Super + Shift + C` |
| **Switch workspace**      | `Super + {1..0}`    |
| **Focus window**          | `Super + {H, J, K, L}` |
| **Fullscreen window**     | `Super + F`         |

Other hotkeys are available in the [sway config](config_files/config).

---

## License

© Lomarco — see LICENSE file for details.
# Lomarco's Dotfiles

<p align="center">
  <img src="docs/1.png" alt="Lomarco's Dotfiles preview" width="600" />
</p>

<details open>
<summary>📚 Table of Contents</summary>

- [Toolchain](#toolchain)
- [Gallery](#gallery)
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
  - [Scripts](#scripts)
    - [auto_backup](#auto_backup)
    - [efistub-boot](#efistub-boot)
    - [mir-sync](#mir-sync)
    - [udp](#udp)
    - [udy](#udy)
- [Sway Hotkeys](#sway-hotkeys)
- [License](#license)

</details>

---

## Toolchain

| Component            | Description                        |
|----------------------|----------------------------------|
| **OS**               | `Arch Linux`                     |
| **Kernel**           | `Linux zen`                      |
| **Window Manager**   | `Sway`                           |
| **Status Bar**       | `I3status`                       |
| **Terminal**         | `Foot`                           |
| **Shell**            | `Zsh + znap`                     |
| **Editor**           | `NeoVim`                        |
| **Multiplexer**      | `Tmux`                           |
| **Notification**     | `Mako`                           |
| **AUR Helper**       | `Paru`                           |
| **Password Manager** | `Pass`                          |
| **Bootloader**       | `EFI Stub`                      |
| **WiFi Manager**     | `Iwd`                           |
| **File Manager**     | `Lf`                             |

---

## Gallery

<p align="center">
  <img src="docs/2.png" alt="Screenshot 1" width="600" />
  <br><br>
  <img src="docs/3.png" alt="Screenshot 2" width="600" />
</p>

---

## Repository Structure

### Base

- [Sway Configuration](base/config)  
- [I3status Configuration](base/config_i3status)  
- [Foot Configuration](base/foot.ini)  
- [Git Config](base/gitconfig)  
- [NeoVim Configuration](base/init.lua)  
- [Tmux Configuration](base/tmux.conf)  
- [Vim Configuration](base/vimrc)  
- [Zsh Configuration](base/zshrc)  

### Extra

- [Fstab](extra/fstab)  
- [Pacman Configuration](extra/pacman.conf)  
- [Iwd Configuration](extra/main.conf)  
- [Mkinitcpio Configuration](extra/mkinitcpio.conf)  
- [Paru Configuration](extra/paru.conf)  
- [Kernel Configuration](extra/kernel_config)  

### Scripts

- [auto_backup](scr/auto_backup)  
- [efistub-boot](scr/efistub-boot)  
- [mir-sync](scr/mir-sync)  
- [udp](scr/udp)  
- [udy](scr/udy)  

---

## Sway Hotkeys

| Action                  | Shortcut             |
|-------------------------|---------------------|
| **Open terminal**       | `Super + Enter`      |
| **Launch browser**      | `Super + Shift + B`  |
| **Launch wmenu**        | `Super + P`          |
| **Take screenshot**     | `PrintScreen`        |
| **Kill window**         | `Super + Shift + Q`  |
| **Exit sway**           | `Super + Shift + E`  |
| **Reload sway config**  | `Super + Shift + C`  |
| **Switch workspace**    | `Super + {1..0}`     |
| **Focus window**        | `Super + {H, J, K, L}` |
| **Fullscreen window**   | `Super + F`          |

Other hotkeys can be found in the [sway config](config_files/config).

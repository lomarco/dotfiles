if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

HISTFILE=~/.cache/zh
HISTSIZE=1000
SAVEHIST=3000
setopt sharehistory hist_ignore_dups hist_reduce_blanks extendedglob nobeep nonomatch

zstyle ':completion:*' list-colors 'di=34:fi=0:ln=36'
zstyle ':completion:*' use-cache yes
zstyle ':completion:*' cache-path ~/.cache/zcache
autoload -Uz compinit
compinit -C -d ~/.cache/zcompdump

bindkey -v
bindkey -M viins "jk" vi-cmd-mode
bindkey '^R' history-incremental-search-backward

alias ls='ls --color=tty' \
  la='ls -la' \
  c='clear' \
  gco='git checkout' \
  gw='git switch' \
  gd='git diff' \
  ga='git add' \
  gc='git commit' \
  gp='git push' \
  gu='git pull' \
  gl='git log --oneline --graph --all' \
  gs='git status --short' \
  gb='git branch' \
  gcl='git clone --depth 1' \
  gr='git remote' \
  m='make' \
  mc='make clean' \
  mi='make install' \
  mr='make rebuild'

export PATH="$PATH:$HOME/.ghcup/bin"
export GPG_TTY=$TTY

ssh-add -l >/dev/null 2>&1 || eval $(ssh-agent -s)
gpg-connect-agent updatestartuptty /bye 1>/dev/null
export SSH_AUTH_SOCK=$(gpgconf --list-dir agent-ssh-socket)

zmodload zsh/zprof

typeset -gr ZSH_PKGS_DIR=~/.cache/ZSH_PKGS
[[ ! -d $ZSH_PKGS_DIR ]] && mkdir -p $ZSH_PKGS_DIR

update_zsh_pkgs() {
  local pkgs=(
    "zsh-users/zsh-autosuggestions"
    "zdharma-continuum/fast-syntax-highlighting" 
    "romkatv/powerlevel10k"
  )
  
  for pkg in "${pkgs[@]}"; do
    local dir="$ZSH_PKGS_DIR/${pkg##*/}"
    [[ -d $dir/.git ]] && (cd $dir && git pull) || git clone --depth=1 "https://github.com/$pkg.git" "$dir" &
    zcompile -U **/*.zsh(**/)
  done
  wait
}

source $ZSH_PKGS_DIR/powerlevel10k/powerlevel10k.zsh-theme
source $ZSH_PKGS_DIR/zsh-autosuggestions/zsh-autosuggestions.zsh
source $ZSH_PKGS_DIR/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

alias zsh-update="rm -rf ~/.cache/ZSH_PKGS/* && update_zsh_pkgs"

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

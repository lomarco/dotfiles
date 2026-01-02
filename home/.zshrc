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
  mr='make rebuild' \
  ztest="hyperfine -N -w 10 -r 50 'zsh -i -c exit'"

export PATH="$PATH:$HOME/.ghcup/bin"
export GPG_TTY=$TTY

ssh-add -l >/dev/null 2>&1 || eval $(ssh-agent -s)
gpg-connect-agent updatestartuptty /bye 1>/dev/null
export SSH_AUTH_SOCK=$(gpgconf --list-dir agent-ssh-socket)

zmodload zsh/zprof

typeset -gr RAC_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/rac"
[[ -d $RAC_HOME ]] || git clone --depth 1 https://github.com/lomarco/rac.git $RAC_HOME; zcompile -U $RAC_HOME/rac.zsh
source $RAC_HOME/rac.zsh

rac load "romkatv/powerlevel10k" \
  "zsh-users/zsh-autosuggestions" \
  "zdharma-continuum/fast-syntax-highlighting"

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

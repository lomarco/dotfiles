[[ ${ZDOTDIR:-$HOME}/.zshrc.zwc -nt ${ZDOTDIR:-$HOME}/.zshrc ]] ||
  zcompile ${ZDOTDIR:-$HOME}/.zshrc 2>/dev/null

setopt sharehistory hist_ignore_dups hist_reduce_blanks extendedglob nobeep nonomatch prompt_subst

_c=${XDG_CACHE_HOME:-$HOME/.cache}
_s=${XDG_STATE_HOME:-$HOME/.local/state}/zsh
[[ -d $_c && -d $_s ]] || command mkdir -p $_c $_s

HISTFILE=$_s/history
HISTSIZE=30000
SAVEHIST=30000
KEYTIMEOUT=20

zstyle ':completion:*' list-colors 'di=34:fi=0:ln=36'
zstyle ':completion:*' use-cache yes
zstyle ':completion:*' cache-path $_c/zcache
autoload -Uz compinit
_d=$_c/zcompdump
if [[ -s $_d && -z $_d(#qN.mh+24) ]]; then
  compinit -C -d $_d
else
  compinit -i -d $_d && command touch $_d
fi
[[ $_d.zwc -nt $_d ]] || zcompile $_d
unset _c _s _d

_gp= _gp_fd= _gp_root=

_gp_precmd() {
  emulate -L zsh
  local d=$PWD
  until [[ -e $d/.git || $d == / ]]; do d=${d:h}; done
  if [[ -n $_gp_fd ]]; then
    zle -F $_gp_fd
    builtin exec {_gp_fd}<&-
    _gp_fd=
  fi
  if [[ ! -e $d/.git ]]; then _gp=; _gp_root=; return; fi
  [[ $d == "$_gp_root" ]] || _gp=
  _gp_root=$d
  exec {_gp_fd}< <(GIT_OPTIONAL_LOCKS=0 command git status --porcelain=v2 -b --show-stash 2>/dev/null)
  [[ $ZSH_VERSION == (5.<8->|<6->.)* ]] || command true
  zle -F $_gp_fd _gp_cb
}

_gp_cb() {
  emulate -L zsh
  local out l new= oid head up ahead=0 behind=0 stash=0
  local -a L w unm stg uns unt
  if [[ -z $2 || $2 == hup ]]; then
    IFS= read -r -d '' -u $1 out
    builtin exec {1}<&-
    L=("${(@f)out}")
    if [[ $L[1] == '# branch.oid '* ]]; then
      for l in $L; do
        [[ $l == '# '* ]] || break
        case $l in
          '# branch.oid '*)      oid=${l##* } ;;
          '# branch.head '*)     head=${l##* } ;;
          '# branch.upstream '*) up=1 ;;
          '# branch.ab '*)       w=(${=l}); ahead=${w[3]#+}; behind=${w[4]#-} ;;
          '# stash '*)           stash=${l##* } ;;
        esac
      done
      unm=(${(M)L:#u\ *})
      stg=(${(M)L:#[12]\ [^.]*})
      uns=(${(M)L:#[12]\ ?[^.]*})
      unt=(${(M)L:#\?\ *})
      if [[ $head == '(detached)' ]]; then
        new="%B%F{cyan}:(%f%b${oid[1,7]}"
      else
        new="%B%F{magenta}${head//\%/%%}%f%b"
      fi
      [[ -n $up ]] || new+='%B%F{red}!%f%b'
      (( behind )) && new+="v$behind"
      (( ahead ))  && new+="^$ahead"
      (( $#unm ))  && new+="%F{red}x$#unm%f"
      (( $#stg ))  && new+="%F{green}+$#stg%f"
      (( $#uns ))  && new+="%F{red}~$#uns%f"
      (( $#unt ))  && new+="%F{yellow}?$#unt%f"
      (( stash ))  && new+="%F{blue}\$$stash%f"
      new+=' '
    fi
    [[ $new == "$_gp" ]] || { _gp=$new; zle reset-prompt }
  fi
  zle -F $1
  _gp_fd=
}

(( $+commands[git] )) && precmd_functions=(${precmd_functions:#_gp_precmd} _gp_precmd)

PROMPT='%(!.%F{red}.)%n@%m%(!.%f.) %B%F{white}%<..<%~%f%b ${_gp}'
PROMPT+='%(!.%(?.%F{green}.%F{red}[%?] )#%f.%(?.%F{green}.%F{red}[%?] )$%f) '

bindkey -v
bindkey -M viins "jk" vi-cmd-mode
bindkey '^R' history-incremental-search-backward

alias ls='ls --color=tty' \
  la='ls -lah' \
  c='clear' \
  gco='git checkout' \
  gw='git switch' \
  gd='git diff' \
  gds='git diff --staged' \
  ga='git add' \
  gc='git commit' \
  gp='git push' \
  gu='git pull' \
  gl='git log --oneline --graph --all' \
  gs='git status --short' \
  gst='git stash' \
  gb='git branch' \
  gcl='git clone --depth 1' \
  gr='git remote' \
  m='make' \
  mc='make clean' \
  mi='make install' \
  mr='make rebuild' \
  cb='cargo build' \
  cr='cargo run' \
  cbr='cargo build --release' \
  crr='cargo run --release' \
  ztest="hyperfine -N -w 10 -r 50 'zsh -i -c exit'" \
  ..="cd .."

export GPG_TTY=$TTY
ssh-add -l >/dev/null 2>&1 || eval $(ssh-agent -s)
gpg-connect-agent updatestartuptty /bye 1>/dev/null
export SSH_AUTH_SOCK=$(gpgconf --list-dir agent-ssh-socket)

RAC_DIR=${XDG_DATA_HOME:-$HOME/.local/share}/rac
[[ -r $RAC_DIR/rac.zsh ]] || git clone -q --depth 1 https://github.com/lomarco/rac $RAC_DIR
source $RAC_DIR/rac.zsh
rac load zsh-users/zsh-autosuggestions zdharma-continuum/fast-syntax-highlighting

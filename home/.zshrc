# Prealiases and other useful init stuff for plugins {{{
alias ls="ls --color -F"
setopt promptsubst

bindkey -e
# }}}
# Dotfile management {{{
source $HOME/.homesick/repos/homeshick/homeshick.sh
fpath=($HOME/.homesick/repos/homeshick/completions $fpath)
# }}}

# Plugin management {{{
source $HOME/.zplugin/zplugin.zsh

zplugin load "zsh-users/zsh-syntax-highlighting"

# Make sure to use double quotes
zplugin load "zsh-users/zsh-history-substring-search"

# Use the package as a command
# And accept glob patterns (e.g., brace, wildcard, ...)
zplugin load "Jxck/dotfiles" # use:"bin/{histuniq,color}"

# a ranger-lite (alt+k)
#zplugin load "Vifon/deer" #, of:"*.sh"

zplugin load "arzzen/calc.plugin.zsh" #, as:command


zplugin snippet 'https://github.com/robbyrussell/oh-my-zsh/raw/master/lib/git.zsh'
zplugin snippet 'https://github.com/robbyrussell/oh-my-zsh/raw/master/plugins/git/git.plugin.zsh'

zplugin load "supercrabtree/k"

zplugin load "dbkaplun/smart-cd"

zplugin load "oz/safe-paste"

#zplugin load "arlimus/zero.zsh"
# the following is redundant with zero.zsh
zplugin load "mollifier/cd-gitroot" #, as:command

zplugin load "chrissicool/zsh-256color"
zplugin load "willghatch/zsh-hooks"

# like ViM easymotion
zplugin load "hchbaw/zce.zsh"

zplugin load "zsh-users/zsh-autosuggestions"



# }}}

# Customize plugins {{{
SMART_CD_GIT_STATUS=false

bindkey "^Xz" zce
# }}}

# Embedded theme {{{
autoload -Uz colors && colors
# Dracula Theme v1.2.1
#
# https://github.com/zenorocha/dracula-theme
#
# Copyright 2015, All rights reserved
#
# Code licensed under the MIT license
# http://zenorocha.mit-license.org
#
# @author Zeno Rocha <hi@zenorocha.com>

local ret_status="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )"

PROMPT='${ret_status}%{$fg_bold[green]%}%p %{$fg_bold[blue]%}%c $(git_prompt_info)% %{$reset_color%}'

ZSH_THEME_GIT_PROMPT_CLEAN=") %{$fg_bold[green]%}✔ "
ZSH_THEME_GIT_PROMPT_DIRTY=") %{$fg_bold[yellow]%}✗ "
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[cyan]%}("
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
# }}}

# Customize to my needs
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:approximate:*' max-errors 3 numeric
autoload -Uz compinit
compinit
setopt HIST_IGNORE_DUPS
setopt extended_glob
setopt AUTO_CD
setopt histignorespace

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

[[ -n "${key[Up]}"   ]] && bindkey "${key[Up]}"   up-line-or-beginning-search
[[ -n "${key[Down]}" ]] && bindkey "${key[Down]}" down-line-or-beginning-search

cdUndoKey() {
  popd      > /dev/null
  zle       reset-prompt
  echo
  ls
  echo
}

cdParentKey() {
  pushd .. > /dev/null
  zle      reset-prompt
  echo
  ls
  echo
}

zle -N                 cdParentKey
zle -N                 cdUndoKey
bindkey '^[[1;3A'      cdParentKey
bindkey '^[[1;3D'      cdUndoKey

#zmodload zsh/terminfo
#bindkey "$terminfo[kcuu1]" history-substring-search-up
#bindkey "$terminfo[kcud1]" history-substring-search-down
#bindkey "$terminfo[cuu1]" history-substring-search-up
#bindkey "$terminfo[cud1]" history-substring-search-down
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey "^[[F" end-of-line
bindkey "^[[H" beginning-of-line
bindkey "^[[1;5D" backward-word
bindkey "^[[1;5C" forward-word

LS_COLORS='rs=0:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=01;32:';
export LS_COLORS
ZSH_HIGHLIGHT_STYLES[path]='fg=cyan'

export BROWSER="chromium"
export EDITOR="nvim"

TERMINOLOGY=/usr/bin/terminology
TERMINATOR=/usr/bin/terminator
if [ -f $TERMINOLOGY ]; then
    export TERMINAL=$TERMINOLOGY
elif [ -f "$TERMINATOR" ]; then
    export TERMINAL=$TERMINATOR
else
    export TERMINAL=xterm
fi

XSCREENSAVER=/usr/bin/xscreensaver-command
I3LOCK=/usr/bin/i3lock
if [ -f $XSCREENSAVER ]; then
    export SCREENLOCK="$XSCREENSAVER -lock"
elif [ -f $I3LOCK ]; then
    export SCREENLOCK=$I3LOCK
fi

export TERM="xterm-256color"
export DEBEMAIL="Tony Cheneau <tony.cheneau@amnesiak.org>"
export DEBFULLNAME="Tony Cheneau"

# my aliases
alias vimtab="gvim --remote-tab"
alias dac="cp ~/.asoundrc.dac ~/.asoundrc"
alias nodac="cp ~/.asoundrc.nodac ~/.asoundrc"
alias logitech="cp ~/.asoundrc.logitech ~/.asoundrc"
alias nv=nvim
alias mb="mbsync -V amnesiak-inbox"
alias ec="emacsclient --alternate-editor '' -n"

# my functions
# -- coloured manuals
man() {
  env \
    LESS_TERMCAP_mb=$(printf "\e[1;31m") \
    LESS_TERMCAP_md=$(printf "\e[1;31m") \
    LESS_TERMCAP_me=$(printf "\e[0m") \
    LESS_TERMCAP_se=$(printf "\e[0m") \
    LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
    LESS_TERMCAP_ue=$(printf "\e[0m") \
    LESS_TERMCAP_us=$(printf "\e[1;32m") \
    man "$@"
}


if [ -e /usr/share/autojump/autojump.zsh ]; then
  source /usr/share/autojump/autojump.zsh
fi

if [ -e /etc/bash_completion.d/virtualenvwrapper ]; then
  source /etc/bash_completion.d/virtualenvwrapper
fi

export LIBVIRT_DEFAULT_URI=qemu:///system
export CHROMIUM_FLAGS='--enable-remote-extensions'

[ -e /usr/bin/virtualenvwrapper_lazy.sh ] && source /usr/bin/virtualenvwrapper_lazy.sh

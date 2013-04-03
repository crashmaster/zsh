autoload -U compinit
compinit

setopt auto_menu
setopt auto_remove_slash
setopt complete_in_word
setopt always_to_end
setopt glob_complete
unsetopt list_beep
unsetopt recexact

zstyle ':completion::complete:*' use-cache 1
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'
zstyle ':completion:*' menu select=6
zstyle ':completion:*:*:(rm|kill|diff):*:*' ignore-line yes
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*' special-dirs ..
zstyle ':completion:*:default' list-colors 'di=34;01:'

local _myhosts
_myhosts=( ${${${${(f)"$(<$HOME/.ssh/known_hosts)"}:#[0-9]*}%%\ *}%%,*} )
zstyle ':completion:*' hosts $_myhosts

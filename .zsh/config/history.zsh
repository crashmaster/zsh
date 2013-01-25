setopt EXTENDED_HISTORY
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY

HISTFILE=~/.zsh_history
HISTSIZE=20000
SAVEHIST=20000

(( $+widgets[history-incremental-pattern-search-backward] )) && \
    bindkey '^r' history-incremental-pattern-search-backward

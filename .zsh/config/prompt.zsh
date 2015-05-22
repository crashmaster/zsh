setopt prompt_subst

autoload -U promptinit
promptinit

PS1="%m %U[%T]%u [%~] -> "

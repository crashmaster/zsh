autoload -U promptinit
promptinit

if [[ "$_myccview" != "** NONE **" ]] && [ -n "$_myccview" ]; then
    PS1="%m %U[%T]%u [$_myccview][%~] -> "
else
    PS1="%m %U[%T]%u [%~] -> "
fi

[[ -r $0.site ]] && source $0.site

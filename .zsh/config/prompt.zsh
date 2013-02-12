autoload -U promptinit
promptinit

if [ -n "$CCVIEW" ]; then
    PS1="%m %U[%T]%u [$CCVIEW][%~] -> "
else
    PS1="%m %U[%T]%u [%~] -> "
fi

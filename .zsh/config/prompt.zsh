autoload -U promptinit
promptinit

if [[ $_myccview != "** NONE **" ]]; then
PS1="%{$fg[green]%}%n%{$fg[white]%}@%{$fg[green]%}%m%{$fg[white]%}(%{$fg[green]%}$_myccview%{$fg[white]%}) %~
%{$fg[green]%}%% %{$reset_color%}"
else
PS1="%{$fg[green]%}%n%{$fg[white]%}@%{$fg[green]%}%m%{$fg[white]%} %~
%{$fg[green]%}%% %{$reset_color%}"
fi

[[ -r $0.site ]] && source $0.site

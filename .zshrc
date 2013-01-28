# {{{ All the startup files
#
# /etc/zshenv       Always run for every zsh.
# ~/.zshenv         Usually run for every zsh.
# /etc/zprofile     Run for login shells.
# ~/.zprofile       Run for login shells.
# /etc/zshrc        Run for interactive shells.
# ~/.zshrc          Run for interactive shells.
# /etc/zlogin       Run for login shells.
# ~/.zlogin         Run for login shells.
#
# }}}

# {{{ Setup zsh's home directory
ZSH=${ZDOTDIR:-$HOME}/.zsh
# }}}

# {{{ Add functions and completions directories to the fpath,
#     and "register" function names, to be loaded upon calling
fpath=($ZSH/functions $ZSH/completions $fpath)
autoload -Uz ${(f)"$(/bin/ls $ZSH/functions)"}
# }}}

# {{{ Kind of modular config file structure
# Note: the config file's name determines the sourcing order!
loader() {
    for config_file ($ZSH/config/*.zsh) source $config_file
} && loader
# }}}

# {{{ Fold the vim modline too, just for the sake of consistency :-)
# vim:fdm=marker
# }}}


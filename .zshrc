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
ZSH="${ZDOTDIR:-$HOME}/.zsh"
ZSH_FUNCTIONS="${ZSH}/functions"
ZSH_COMPLETIONS="${ZSH}/completions"
ZSH_CONFIG="${ZSH}/config"
# }}}

# {{{ Declare path environment variables as arrays, which have unique elements.
typeset -aU path
typeset -aU ld_library_path
# }}}

# {{{ Add functions and completions directories to the fpath,
#     and "register" function names, to be loaded upon calling
fpath=(${ZSH_FUNCTIONS} ${ZSH_COMPLETIONS} $fpath)
autoload -Uz ${ZSH_FUNCTIONS}/*(:t)
# }}}

# {{{ Kind of modular config file structure
# Note: the config file's name determines the sourcing order!
loader() {
    setopt extendedglob

    # Collect *.zsh files under config directory, except for *site.zsh.
    # Note: we have 01_site_settings.zsh, which must be processed,
    # so ~*site* would not work. If we have a *.site.zsh file, then
    # process it right after the corresponding config file.
    for config_file in ${ZSH_CONFIG}/*.zsh~*site.zsh
    do
        source ${config_file}
        config_file_without_extension=${config_file:r}
        site_config_file=${config_file_without_extension}.site.zsh
        [[ -r ${site_config_file} ]] && source ${site_config_file}
    done
} && loader
# }}}

# {{{ Fold the vim modline too, just for the sake of consistency :-)
# vim:fdm=marker
# }}}

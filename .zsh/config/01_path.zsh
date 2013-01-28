conf_func() {
    add_to_path $HOME/bin
} && conf_func && unfunction conf_func

[[ -r $0.site ]] && source $0.site

conf_func() {
    local to_add
    to_add=($HOME/lib64 $HOME/lib)
    add_to_ld_path $to_add
} && conf_func && unfunction conf_func

conf_func() {
    local to_add
    to_add=($HOME/bin)
    add_to_path $to_add
} && conf_func && unfunction conf_func

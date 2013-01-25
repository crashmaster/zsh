conf_func() {
    local to_add
    local p
    to_add=($HOME/lib64 $HOME/lib)
    for p in $to_add
    do
        # The (r) flag takes a pattern and substitutes the first element
        # of the array matched.
        # 1 is substituted, when $p was found.
        (( ${${path[(r)$p]}:+1} )) || {
            [ -d $p ] && LD_LIBRARY_PATH=$p:$LD_LIBRARY_PATH
        }
    done
    export LD_LIBRARY_PATH
} && conf_func && unfunction conf_func


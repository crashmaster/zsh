conf_func() {
    local to_add
    to_add=(/env/seki/bin
            /usr/atria/bin
            /app/git/1.8.0.2/LMWP2/bin
            $HOME/bin
            $HOME/work/cudb/bin)
    local p
    for p in $to_add
    do
        # The (r) flag takes a pattern and substitutes the first element
        # of the array matched.
        # 1 is substituted, when $p was found.
        (( ${${path[(r)$p]}:+1} )) || {
            [ -d $p ] && path=($p $path)
        }
    done
} && conf_func && unfunction conf_func


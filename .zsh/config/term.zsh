conf_func() {
    local term_256c_conn
    term_256c_conn=(ev68b599ec9536 ev0025b3bf465f svi)
    local term_256c=0
    for c in $term_256c_conn
    do
        [[ -z ${${$(host ${SSH_CLIENT[(w)1]})[(w)5]}##$c*} ]] && {
            term_256c=1
            # print_nice_text
            break
        }
    done

    if (( $term_256c )); then
        export PUTTY_TERM=1
        export TERM=xterm-256color
    elif [ -n "${STY+x}" ]; then
        # Running in screen already
        export TERM=xterm-256color
    else
        unfunction print_nice_text
    fi
} && conf_func && unfunction conf_func

autoload -U colors
[[ "$terminfo[colors]" -ge 8 ]] && colors

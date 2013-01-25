print_nice_text() {
    local bgc=$[${RANDOM}%31+200]
    local fgc=0
#    local fgc=$[${RANDOM}%10+16]
    local b_inc=$[${RANDOM}%3+1]
#    local f_inc=$[${RANDOM}%2+1]
    local f_inc=0
    local text
    text=('P' 'u' 'T' 'T' 'Y' ' ' '||' ' ' 'C' 'h' 'r' 'o' 'm' 'e' ' ' '-' '>'
          ' ' '2' '5' '6' ' ' 'C' 'o' 'l' 'o' 'r' 's' '!' ' ' 'o_O')
    for ((i=1; i<=${#text}; i++))
    do
        print -n "\x1b[48;5;${bgc}m\x1b[38;5;${fgc}m ${text[$i]}\x1b[0m";
        ((bgc-=$b_inc))
        ((fgc+=$f_inc))
    done
    print
}

conf_func() {
    local term_256c_conn
    term_256c_conn=(ev0025b3bf465f svi)
    local term_256c=0
    for c in $term_256c_conn
    do
        [[ -z ${${$(host ${SSH_CLIENT[(w)1]})[(w)5]}##$c*} ]] && {
            term_256c=1
            export PUTTY_TERM=1
            # print_nice_text
            export TERM=xterm-256color
            break
        }
    done

    if (( $term_256c )); then
        export PUTTY_TERM=1
        export TERM=xterm-256color
    else
        unfunction print_nice_text
    fi
} && conf_func && unfunction conf_func

autoload -U colors
[[ "$terminfo[colors]" -ge 8 ]] && colors


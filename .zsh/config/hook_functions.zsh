typeset -ga preexec_functions
typeset -ga precmd_functions
typeset -ga chpwd_functions

# When directory is changed set xterm title to host:dir
update_terminal_title() {
    [[ -t 1 ]] || return
    case $TERM in
        sun-cmd) print -Pn "\e]l%~\e\\";;
        *xterm*|*rxvt*|(dt|k|E)term) print -Pn "\e]2;%m:%~\a";;
    esac
}

precmd_update_terminal_title() {
    update_terminal_title
}
precmd_functions+="precmd_update_terminal_title"

chpwd_update_terminal_title() {
    update_terminal_title
}
chpwd_functions+="chpwd_update_terminal_title"

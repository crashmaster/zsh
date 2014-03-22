chpwd_functions=("change_terminal_title")

# When directory is changed set xterm title to host:dir
change_terminal_title() {
    [[ -t 1 ]] || return
    case $TERM in
        sun-cmd) print -Pn "\e]l%~\e\\";;
        *xterm*|*rxvt*|(dt|k|E)term) print -Pn "\e]2;%m:%~\a";;
    esac
}

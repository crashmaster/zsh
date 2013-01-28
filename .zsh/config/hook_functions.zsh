# When directory is changed set xterm title to host:dir
chpwd() {
    [[ -t 1 ]] || return
    case $TERM in
        sun-cmd) print -Pn "\e]l%~\e\\";;
        *xterm*|rxvt|(dt|k|E)term) print -Pn "\e]2;%m:%~\a";;
    esac
}

preexec() {
  if [ -n "${STY+x}" ]; then
    if [[ $_myccview = "** NONE **" ]] || [ -z "$_myccview" ]; then
      print -Pn "\ek%m\e\\"
    else
      print -Pn "\ek$_myccview\e\\"
    fi
  else
    : "probably not in screen"
  fi
} && preexec

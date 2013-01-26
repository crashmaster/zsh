### disk usage
alias df='df -h'
alias du='du -h'

### ps
alias p="/bin/ps -fu $USER"
alias pt="/usr/bin/pstree -Achln $USER"

### ls
alias l='/bin/ls -alF --color'
alias ltr='/bin/ls -alFtr --color'

### cd
alias ..='cd ..'
alias ...='cd ../..'

### ClearCase stuff
CLEARTOOL=/usr/atria/bin/cleartool
alias ct="$CLEARTOOL"
alias sv="$CLEARTOOL setview"
[[ -n $CLEARCASE_ROOT ]] && {
    # Note: there is /usr/bin/ci (check in RCS revisions)
    alias ci="$CLEARTOOL checkin" #TODO: try "-atomic"
    # Note: there is /usr/bin/co (Compare two sorted files line by line)
    alias co="$CLEARTOOL checkout -unre -nc"
    alias ctdesc="$CLEARTOOL desc"
    alias unco="$CLEARTOOL uncheckout -rm"

    alias cudb='cd /vobs/gdb/cudb'
}

[[ -r $0.site ]] && source $0.site

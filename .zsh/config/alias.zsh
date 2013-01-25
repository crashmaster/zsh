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

### editors
alias vim='/app/vim/7.3.496/LMWP2/bin/vim'
alias v='/app/vim/7.3.496/LMWP2/bin/vim -p'
alias vd='/app/vim/7.3.496/LMWP2/bin/vimdiff'
alias vlsco='/app/vim/7.3.496/LMWP2/bin/vim -p `lsco`'

### ClearCase stuff
alias ci='/usr/atria/bin/cleartool checkin' #TODO: try '-atomic'
alias co='/usr/atria/bin/cleartool checkout -unre -nc'
alias ct='/usr/atria/bin/cleartool'
alias ctdesc='/usr/atria/bin/cleartool desc'
alias sv='/usr/atria/bin/cleartool setview'
alias unco='/usr/atria/bin/cleartool uncheckout -rm'

[[ -n $CLEARCASE_ROOT ]] && {
    alias cudb='cd /vobs/gdb/cudb'
}

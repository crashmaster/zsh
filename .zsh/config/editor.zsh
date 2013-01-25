conf_func() {
    local -a editors
    local editor
    editors=("vim" "vi" "joe")
    for editor in $editors
    do
        (( ${+commands[$editor[(w)1]]} )) && {
            export EDITOR=$editor
            export VISUAL=$editor
            break;
        }
    done
} && conf_func && unfunction conf_func


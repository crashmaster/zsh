conf_func() {
    local dir
    local dirs_to_create
    dirs_to_create=($HOME/bin               # ext compiled binaries
                    $HOME/docs              # my/ext various documents
                    $HOME/etc               # my/ext various configs
                    $HOME/src               # sources for ext applications
                    $HOME/tmp               # temp dir
                    $HOME/usr               # all my various stuff goes here
                    $HOME/usr/bin           # my various executable files
                    $HOME/usr/src           # my various source files
                    $HOME/usr/src/git       # my various git stuff
                    $HOME/usr/prototype     # my various prototype stuff
                    $HOME/work)             # my work related stuff

    for dir in $dirs_to_create
    do
        [[ ! -d $dir ]] && {
            print -n "expected directory: $dir not found, create it... "
            mkdir -p $dir
            print "done :-)"
        }
    done
} && conf_func && unfunction conf_func


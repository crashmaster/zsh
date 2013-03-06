# Set less options
if [[ -x $(which less) ]]
then
    export PAGER="less"
fi

# Set less history file
export LESSHISTFILE="$HOME/.lesshst"

# Set less' history file size
export LESSHISTSIZE=50

# Say how long a command took, if it took more than 30 seconds
export REPORTTIME=30

# Prompts for confirmation after 'rm *' etc
setopt RM_STAR_WAIT

# Don't write over existing files with >, use >! instead
setopt NOCLOBBER

# Don't nice background processes
setopt NO_BG_NICE

# ls in colors + add / to directory names
LS_OPTIONS=--color=auto
LS_OPTIONS="-N $LS_OPTIONS -T 0 -p"

autoload -U colors
[[ "$terminfo[colors]" -ge 8 ]] && colors

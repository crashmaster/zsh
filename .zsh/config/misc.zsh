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

# Add '|' to output redirections in the history. This allows history references to clobber files
# even when CLOBBER is unset.
setopt HIST_ALLOW_CLOBBER

# A word beginning with the third character of the histchars parameter (`#' by default) causes
# that word and all the following characters up to a newline to be ignored.
setopt INTERACTIVE_COMMENTS

# Don't nice background processes
setopt NO_BG_NICE

# ls in colors + add / to directory names
export LS_OPTIONS="-N --color=auto -T 0 -p"

# grep in colors
export MY_GREP_OPTIONS='--color=auto'

autoload -U colors
[[ "$terminfo[colors]" -ge 8 ]] && colors

[[ -r ~/.dircolors ]] && eval `dircolors ~/.dircolors`

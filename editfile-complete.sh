# add completion for editfile categories
# note that this file must be sourced
#
# Ben Bass 2012 @codedstructure

_editfile()
{
    local curw
    COMPREPLY=()
    curw=${COMP_WORDS[COMP_CWORD]}
    # only offer expansions if nothing currently there
    LIMIT=3
    # if the previous word is an option which can take
    # a category argument, then don't stop yet!
    if [[ ${COMP_WORDS[${#COMP_WORDS[@]} - 2]} =~ -[al] ]] ; then
        LIMIT=4
    fi
    if [[ ${#COMP_WORDS[@]} -lt $LIMIT ]] ; then
        COMPREPLY=($(compgen -W '$(cd ~/Dropbox/editfile/$1; find  * -maxdepth 1 -type f | sed s/\.txt$//g)' -- $curw))
    fi
    return 0
}

for ff in $(find -L ~/bin -maxdepth 1 -samefile ~/bin/editfile); do
    complete -F _editfile $(basename $ff)
done


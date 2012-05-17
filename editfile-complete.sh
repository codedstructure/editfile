# add completion for editfile categories
# note that this file must be sourced
#
# Ben Bass 2012 @codedstructure

# This doesn't declare global constants as it gets sourced
# and doesn't want to pollute the environment. But it does
# assume ~/Dropbox/editfile/ is the correct EDITFILE_DIR

_list_files()
{
    if ! [[ -d ~/Dropbox/editfile/$1 ]] ; then
        return
    fi
    cd ~/Dropbox/editfile/$1 2> /dev/null || return
    find * -maxdepth 1 -type f 2> /dev/null | sed 's/\.txt$//g' | sed 's/ /\\ /g'
}

_editfile()
{
    local curw
    COMPREPLY=()
    curw=${COMP_WORDS[COMP_CWORD]}
    # only offer expansions if nothing currently there
    LIMIT=3
    # if the previous word is an option which can take
    # a category argument, then don't stop yet!
    if [[ ${COMP_WORDS[${#COMP_WORDS[@]} - 2]} =~ -[alf] ]] ; then
        LIMIT=4
    fi
    if [[ ${#COMP_WORDS[@]} -lt $LIMIT ]] ; then
        saveIFS=$IFS
        IFS=$'\n'
        COMPREPLY=($(compgen -W '$(_list_files $1)' -- $curw))
        IFS=$saveIFS
    fi
    return 0
}

for p in $(echo $PATH | tr : \\n | sort | uniq); do
    for ff in $(find -L $p -maxdepth 1 -perm -100 -samefile $(which editfile) 2> /dev/null); do
        complete -o nospace -F _editfile $(basename $ff)
    done
done

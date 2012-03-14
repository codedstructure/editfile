_editfile()
{
    local curw
    COMPREPLY=()
    curw=${COMP_WORDS[COMP_CWORD]}
    # only offer expansions if nothing currently there
    if [[ ${#COMP_WORDS[@]} -lt 3 ]] ; then
        COMPREPLY=($(compgen -W '$(cd ~/Dropbox/editfile/$1; find  * -maxdepth 1 -type f | sed s/\.txt$//g)' -- $curw))
    fi
    return 0
}

find -L ~/bin -maxdepth 1 -samefile ~/bin/editfile | while read F ; do
    echo $(basename $F)
    complete -F _editfile $(basename $F)
done

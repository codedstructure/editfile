========
editfile
========

Usage
-----

::

    Usage: EDITFILE_NAME [OPTIONS] [CATEGORY]
      default operation is to edit the file

    Options:
      -h    this help
      -a    append stdin to the file
      -l    output the file to stdout
     (Note these options are mutually exclusive)

The key thought behind editfile is that a user shouldn't have to specify two
words ('edit', 'this file') when editing regularly used files, but rather just
a simple declaration ('notes', 'todo', etc). Obviously there are limits to this
approach with the flat(ish) namespace of commands in the path, but I have found
it helpful.

Two things change it from a curiosity to something useful for me:

- syncing across devices (via Dropbox)
- not having to worry about where I am in the path, or where the target file is
  means I use it all the time

As a concession to complexity, it provides a two-level deep hierarchy, where for
each command, a category can also be given (though isn't necessary).

Examples
--------

*These assume 'notes' and 'todo' are editfile commands*::

    $ notes   # will start editing the file associated with the 'notes' command
    $ echo "This will be appended to the end of the notes files" | notes -a
    $ notes -l > notes.backup  # -l dumps the file to standard output
    $ notes errands  # edit the 'errands' file in the notes namespace
    $ notes -l errands   # as you expect
    $ todo -l | notes -a errands   # append content of 'todo' to 'notes/errands'

Default installation
--------------------

Other than its dependency on a basic POSIX system running Bash, editfile assumes
two other things:

- a writable dropbox folder lives in ~/Dropbox (~/Dropbox/editfile/ is used)
- **editfile** and appropriately named symlinks to it live in ~/bin

Copy **editfile** to ~/bin, ensure it is executable. Create symlinks as
appropriate to it in the same place, for example:

::

    $ pwd
    /home/users/ben/bin
    $ ln -s editfile notes
    $ ln -s editfile today
    $ ln -s editfile blog
    $ ln -s editfile todo

A tab-completion expander thing is also provided as **editfile-complete.sh**,
which needs sourcing in an appropriate place in the shells where it is
to be used.

*Ben Bass 2012 @codedstructure*

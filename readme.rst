========
editfile
========

Normal Usage
------------

::

    Usage: EDITFILE_NAME [OPTIONS] [CATEGORY]
      default operation is to edit the file

    Options:
      -h    this help
      -a    append stdin to the file
      -l    output the file to stdout
      -f    output file path name to stdout
     (Note these options are mutually exclusive)

The key thought behind ``editfile`` is that a user shouldn't have to specify two
words ('edit', 'this file') when editing regularly used files, but rather just
a simple declaration ('notes', 'todo', etc). Obviously there are limits to this
approach with the flat(ish) namespace of commands in the path, but I have found
it helpful.

Two things change it from a curiosity to something useful for me:

- syncing across devices (via Dropbox)
- not having to worry about where I am in the path -or where the target file -
  is means I use it all the time

As a concession to complexity, it provides a two-level deep hierarchy, where for
each command, a category can also be given (though isn't necessary).

Examples
--------

*These assume 'notes', 'todo' and 'blog' are editfile commands*::

    # start editing the file associated with the 'notes' command
    $ notes

    # -a reads from stdin and appends to the file
    $ echo "This will be appended to the end of the notes files" | notes -a

    # -l dumps the file to standard output
    $ notes -l > notes.backup

    # editfile uses 'EDITOR' if defined, with gedit and vim as fallbacks
    # edit the 'errands' file in the notes namespace with emacs
    $ EDITOR=emacs notes errands

    $ notes -l errands   # as you expect

    $ blog -f editfile
    /home/ben/Dropbox/editfile/blog/editfile.md

    # append content of 'todo' to 'notes/errands'
    $ todo -l | notes -a errands

    # can be given .rst or .md extension to override .txt default
    $ blog first-post.md

    # edit two different things at once, sort of bypassing editfile :-)
    vim $(notes -f) (work -f planning)

    # once file exists, extension is optional (priority: .rst, .md, .txt)
    $ blog first-post  # will edit first-post.md

File & folder layout
--------------------

``editfile`` contains a hardcoded Dropbox path, '``~/Dropbox/editfile``', which
it assumes is a sensible place to put things. The script currently needs editing
if this isn't appropriate.

When using a single level ``editfile`` command (e.g. '``notes``' is a symlink to
``editfile`` and is run simply as '``notes``'), the system will look for a file
of this same name (with appropriate extension - see following) under
``~/Dropbox/editfile/``, and take the appropriate action (edit, list, append).

When a second label is given after the command, then the file acted upon
is instead under ``~/Dropbox/editfile/<commandname>/``, with its file name
being the second label.

Originally ``editfile`` always used '.txt' as the file extension appended to the
appropriate command / label, but I've found that I want to use ``editfile`` for
writing blog posts and code documentation, so ReStructured Text (.rst) and
Markdown (.md) file extensions are also supported. When no file exists already,
then .txt will be created unless an extension is specified. For existing files,
if no extension is given then the first match in .rst, .md, .txt will be used.
If more than one of these exists then it is up to the user to sort things out.

Examples
~~~~~~~~

    =====================  ===============
    Command                Referenced File
    =====================  ===============
    $ notes                ~/Dropbox/editfile/notes.txt
    $ notes testing        ~/Dropbox/editfile/notes/testing.txt
    $ blog firstthings.md  ~/Dropbox/editfile/blog/firstthings.md
    $ blog firstthings     ~/Dropbox/editfile/blog/firstthings.md (if it already exists, else .txt)
    =====================  ===============


Tab Completion
--------------

A tab-completion expander script is also provided as ``editfile-complete.sh``,
which needs sourcing in an appropriate place in the shells where it is to be
used. This provides expansion of second level items under each editfile command.
For example, ``notes <tab>`` above would result in a completion containing at
least ``testing``. This is a useful way of checking which sub-files exist for
each editfile command.

If options (-a, -l, -f) are given, then tab completion still occurs after the
option, for example ``notes -l <tab>`` will still auto-complete the notes
sub-files.

Direct use of 'editfile'
------------------------

The normal use of ``editfile`` is via the commands symlinked to it, however by
running editfile directly as a command, these symlinks can be managed. There
are three options:

-l
  list ``editfile`` command names (this looks across the entire ``PATH`` for
  things linking to ``editfile``)

-n <name>
  create a new symlink to ``editfile``. The symlink will be placed in the same
  directory as the ``editfile`` script, so will be in the ``PATH``

-d <name>
  delete an existing ``editfile`` symlink. This could be anywhere on the path,
  but it is checked that it really is a symlink to the ``editfile`` executable.

Default installation
--------------------

Other than its dependency on a basic POSIX system running Bash, ``editfile``
assumes two other things:

- a writable dropbox folder lives in ``~/Dropbox`` (``~/Dropbox/editfile/`` is
  used)
- ``editfile`` and appropriately named symlinks to it live in ``~/bin`` or
  elsewhere in the ``PATH`` (somewhere writable is useful for ``editfile -n``
  etc)

Example installation
~~~~~~~~~~~~~~~~~~~~

Copy ``editfile`` to ``~/bin``, ensure it is executable. Create symlinks as
appropriate to it in the same place, either directly or via the ``editfile -n``
command::

    $ editfile -n notes
    $ editfile -n today
    $ editfile -n blog
    $ editfile -n todo

or::

    $ pwd
    /home/users/ben/bin
    $ ln -s editfile notes
    $ ln -s editfile today
    $ ln -s editfile blog
    $ ln -s editfile todo

*Ben Bass 2012 @codedstructure*

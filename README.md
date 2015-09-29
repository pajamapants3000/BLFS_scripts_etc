# BLFS_scripts_etc
Scripts, patches, notes, and other files and information useful in expanding BLFS (or any Linux) systems

Most of these scripts make use of a handful of functions suggested by the folks
at Linux From Scratch. Ensure that these functions are defined in the
environment; add them to /etc/profile for example. The definitions can be found
in functions.sh in this directory, which can be sourced to provide them if
this is preferrable to adding them to /etc/profile.

These scripts are all in various stages of completeness; most of them have been
used successfully and, while they are still a work in progress, at least do
what they are supposed to.

BATCH INSTALLATION
^^^^^^^^^^^^^^^^^^^
A process for managing large installations or installations with many
dependencies is in place:

Create a list-XXX file, where XXX is the name of the list to be set up. Each
line that does not begin with '#' (non-comment lines) should be the
name-version of a program to be installed, such that there is a script called
name-version.sh in one of the script subfolders. The sccript subfolders are
scripts and scripts/non-blfs; there is also scripts/attention where any
installations requiring manual attention is required. These scripts will
break out of the batch installation to give you a chance to do whatever
you need to before continuing.
They should be listed in order to be installed.

Run:
$./setlist.sh listdir <dir containing list-XXX file>

(listdir should also have a scripts/non-blfs subfolder)

$export LIST=XXX (where XXX is the same as in list-XXX above)
$./generator.sh

This will let you know if any of the queued installations don't have scripts
prepared.

If all necessary scripts are present and executable, links will be created,
prefixed by XXX and the number order. Any programs that appear to already
be installed (LISTFILE below) will be skipped in the generation. To
include these programs anyway (they will each prompt you before installing
instead), pass -a (for "all") to the generator:

$./generator.sh -a

Once you have gotten a successful list generation, begin installing the
programs with:

./listrunner.sh

If at any point or for any reason you want to start listrunner from any given
script in the list, simply pass an argument of the number in the order. If,
for example, you want to proceed from the fourth installation in the list, run

$./listrunner.sh 4

This is useful to pick things back up in case something causes a break out of
the installation.
This process will abort at the encounter of any error. listrunner will tell you
what number it left off at, which would be the installation that produced the
error.

Using this approach, you can work out any dependencies and/or lists of programs
you want to install, and let listrunner do the rest! (Of course you need
the installation scripts for each program to install!)

LISTFILE
^^^^^^^^
At the end of each successful installation, a line is added to
/list-${CHRISTENED}-${SURNAME}
a file in the root directory. You will want to create such a file and make sure
you have read and write permission for it. It is also highly recommended that
you define these variables in /etc/profile. One suggestion is
export CHRISTENED=$(uname -n)
export SURNAME=$(uname -s)

I will add a catch for this in the future so the scripts have a consistent and
resonable backup in case these steps are forgotten or undesireable.

Each installation checks for previous installation by checking this list file.
If one is found, you will be prompted to continue or abort.

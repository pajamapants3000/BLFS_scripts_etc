# BLFS_scripts_etc
Scripts, patches, notes, and other files and information useful in expanding BLFS (or any Linux) systems

***
Most of these scripts make use of a handful of functions suggested by the folks
at Linux From Scratch. Ensure that these functions are defined in the
environment; add them to /etc/profile for example. The definitions can be found
in my LFS repo:
(https://github.com/pajamapants3000/LFS_scripts/blob/master/files/profile.d/bash_function.sh)

Just download and source this from your shell configuration.
***

Configuration<br />
^^^^^^^^^^^^^^<br />
There is a file called "blfs_profile" that contains all relevant system information that
is used by the scripts to build and install properly and according to your system's
configuration. I create a configuration for each computer, and each computer has a name.
blfs_profile is not only a configuration, it is a self-configuring script. When you run
"blfs_profile <computer_name>" the script will comment out all lines pertaining to
other computers and uncomment lines pertaining to the computer called <computer_name>.
I also recommend defining environment variables CHRISTENED and SURNAME. You can use
these however you want, but I use CHRISTENED to identify a specific computer or computer
model, and SURNAME to specify the OS, including version or any other relevant info. So,
my main computer, for example, is currently set to CHRISTENED=Lilu and
SURNAME=lfs-2016-07-23. For more, see "LISTFILE" section below.

***


Most of these scripts have been used successfully. They are formatted differently
depending on when the last version was written; I have modified and improved
the format over time and tried to use a template (scripts/skel.sh) with a
simple configuration to apply reusable logic to specific packages.

When installing a package, check the script for option settings. There are certain lines
that you can comment in or out to change how the package is built and installed. There is
also usually dependency information in the script, and you can change things like prefix
path, etc. Some scripts (the newer ones) also have options to build only, install only
(it will assume you have the package already built in an expected location), preserve files after build, and other settings of this nature. Read the comments.

BATCH INSTALLATION<br />
^^^^^^^^^^^^^^<br />
A process for managing large installations or installations with many
dependencies is in place:

Create a file called "list-XXX", where XXX is the name of the list to be set up - just
whatever you want to call it. Each line in this file that does not begin with '#'
(non-comment lines) should be the name and version of a program to be installed,
such that there is a script called "name-version.sh" in one of the script subfolders.
The script subfolders are "./scripts" and "./scripts/non-blfs"; there is also
"./scripts/attention" where any installations requiring manual attention is required.
These scripts will break out of the batch installation to give you a chance to do whatever
you need to before continuing.

The packages listed in "list-XXX" should simply be a list of packages to install, in order.

The batch installer uses two variables plus an environment variable. "listdir" is the working
directory for the batch installer; "scriptdir" is where the batch installer looks for
package installer scripts. "scriptdir" should also have a "non-blfs" subfolder (this is where
I keep scripts that I created without the help of the folks at Linux From Scratch).

Run:<br />
$./setlist.sh listdir <dir containing list-XXX file>

If listdir is not the parent folder of the "./scripts" directory (with "./non-blfs" subdirectory),
you will also want to run:<br />

$./setlist.sh scriptdir <dir containing package installer scripts><br />

Then, to tell the batch installer the name of the list you want to generate<br />
$./setlist.sh list XXX
$./generator.sh<br />

This will let you know if any of the queued installations don't have scripts
prepared. This is one of the great things about this setup: a.it will tell you
if a package installer script is missing, and b. it will, by default, skip any
packages that are already installed!

If all necessary scripts are present and executable, links will be created,
prefixed by XXX and the number order. Any programs that appear to already
be installed (LISTFILE below) will be skipped in the generation. To
include these programs anyway (they will each prompt you before installing
instead), pass -a (for "all") to the generator:<br />

$./generator.sh -a<br />

Once you have gotten a successful list generation, begin installing the
programs with:<br />

$export LIST=XXX<br />
$./listrunner.sh<br />

The first command puts the list name in the environment, which the list runner
uses to know what list it is running.

If at any point or for any reason you want to start listrunner from any given
script in the list, simply pass an argument of the number in the order. If,
for example, you want to proceed from the fourth installation in the list, run<br />

$./listrunner.sh 4<br />

This is useful to pick things back up in case something causes a break out of
the installation.
This process will abort at the encounter of any error. listrunner will tell you
what number it left off at, which would be the installation that produced the
error.

Using this approach, you can work out any dependencies and/or lists of programs
you want to install, and let listrunner do the rest! (Of course you need
the installation scripts for each program to install!)

LISTFILE<br />
^^^^^^^^^^^^^^<br />
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

BTW, I keep a backup of this file that I periodically copy to, just in case I try to append a
file name by hand and accidentally use "echo <name-version> > /list-${CHRISTENED}-${SURNAME}"
instead of "echo <name-version> >> /list-${CHRISTENED}-${SURNAME}" or something.

***
This was all created for me, but this README will help me remember what I was thinking, and MAY
help anyone else who happens to stumble upon this repo and decide to try it out!

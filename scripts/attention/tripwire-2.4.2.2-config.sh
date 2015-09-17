#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for Tripwire-2.4.2.2
#
# Be sure /etc/tripwire/twpol.txt is configured as desired
# Default will be added during installation, but it should be customized
#   before proceeding.
# Can also proceed as is and change later (see below)
#
#
#pathappend /usr/sbin
#as_root twadmin --create-polfile --site-keyfile /etc/tripwire/site.key \
#    /etc/tripwire/twpol.txt
#as_root tripwire --init
#pathremove /usr/sbin
#
# Usage Information:
# Tripwire will identify file changes in the critical system files specified in
#   the policy file. Using Tripwire while making frequent changes to these
#   directories will flag all these changes. It is most useful after a
#   system has reached a configuration that the user considers stable.
#
# To use Tripwire after creating a policy file to run a report, use
#   the following command:
# $tripwire --check > /etc/tripwire/report.txt
#
# View the output to check the integrity of your files. An automatic integrity
#   report can be produced by using a cron facility to schedule the runs.
#
# Reports are stored in binary and, if desired, encrypted. View reports, as
#   the root user, with:
# $twprint --print-report -r /var/lib/tripwire/report/<report-name.twr>
#
# After you run an integrity check, you should examine the report (or email)
#   and then modify the Tripwire database to reflect the changed files on your
#   system. This is so that Tripwire will not continually notify you that files
#   you intentionally changed are a security violation. To do this you must
#   first ls -l /var/lib/tripwire/report/ and note the name of the newest
#   file which starts with your system name as presented by the command
#   uname -n and ends in .twr. These files were created during report creation
#   and the most current one is needed to update the Tripwire database of your
#   system. As the root user, type in the following command making the
#   appropriate report name:
# $tripwire --update --twrfile /var/lib/tripwire/report/<report-name.twr>
#
# You will be placed into Vim with a copy of the report in front of you. If
#   all the changes were good, then just type :wq and after entering your
#   local key, the database will be updated. If there are files which you
#   still want to be warned about, remove the 'x' before the filename in
#   the report and type :wq.
#
##########################################################################
#                        **********
#              ******************************
#     *****************************************************
# Changing the Policy File
# ^^^^^^^^^^^^^^^^^^^^^^^^
#  If you are unhappy with your policy file and would like to modify it or use
#+ a new one, modify the policy file and then execute the following commands:
#$as_root twadmin --create-polfile /etc/tripwire/twpol.txt
#$as_root tripwire --init
#     *****************************************************
#              ******************************
#                        **********
##########################################################################
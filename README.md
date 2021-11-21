# envylogger - virtual web logfile rotater/parser

This script will take piped logs in STDIN, break off the first component specified as `ENVY_NAME` and log the line into the proper directory under $LOGDIR. It will roll the logs over at midnight on-the-fly and maintain a symlink to the most recent log.

For usage docs read [envylogger.md](envylogger.md)

(c) 2021 - Gergely Nagy <gna@r-us.hu>

see copyright for license information.

envylogger requires perl and Date::Format, availiable from CPAN.

see `envylogger(1)`, or `perldoc envylogger` for usage.

run `make release` to create envylogger.tar.gz package for deployment

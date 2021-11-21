envylogger usage  

# envylogger - flexible log rotation in perl

*   [NAME](#NAME)
*   [SYNOPSIS](#SYNOPSIS)
*   [DESCRIPTION](#DESCRIPTION)
*   [USAGE AND EXAMPLES](#USAGE-AND-EXAMPLES)
    *   [EXAMPLE:](#EXAMPLE)
*   [OPTIONS](#OPTIONS)
*   [SEE ALSO](#SEE-ALSO)
*   [BUGS](#BUGS)
*   [AUTHORS](#AUTHORS)

# NAME

envylogger - flexible log rotation in perl

# SYNOPSIS

envylogger \[OPTIONS\]... \[LOGDIR\]

# DESCRIPTION

envylogger is a redesigned variant of vlogger, to allow custom named VirtualHost folders each containing a logs folder to place logs into. envylogger takes piped output from Apache, splits off the first field, and writes the logs to logfiles into the logs sub-folder of subdirectories. It uses a filehandle cache to avoid resource limitations. It will start a new logfile at the beginning of a new day, and optionally start new files when a certain filesize is reached. It can maintain a symlink to the most recent log for easy access. For Apache 2.4 and up, the same first-field parsing can be enabled, to be used in ErrorLog directives, by specifying an ErrorLogFormat.

# USAGE AND EXAMPLES

To start using envylogger, set the environment variable ENVY\_NAME inside your vhosts' configs to the dirname of your vhost, that contains the 'logs' directory:

## EXAMPLE:

*   **If the full path to your logs dir is:** `/var/www/my_envy_dir/logs/`
    
*   **then set the variable so:** `SetEnv ENVY_NAME my_envy_dir`
    
*   **Next, you need to add the "%{ENVY\_NAME}e" to the first part of your LogFormat:**
    
    `LogFormat "%{ENVY_NAME}e %h %l %u %t \"%r\" %>s %O \"%{Referer}i\" \"%{User-Agent}i\"" envy_combined`
    
*   **Then call it from a customlog:**
    
    `CustomLog "| /usr/local/sbin/envylogger -t access.apache.%Y.%m.%d.log -u www-data -g www-data /var/www" envy_combined`
    
*   **For Apache 2.4+, the same host parsing can be enabled, first you need to add a custom ErrorLogFormat, starting with "%{ENVY\_NAME}e" :**
    
    `ErrorLogFormat "%{ENVY_NAME}e [%{u}t] [%-m:%l] [pid %P] %7F: %E: [client\ %a] %M% ,\ referer\ %{Referer}i"`
    
*   **NOTE: the above format should only used in conjuction with piping ErrorLog to envylogger:**
    
    `ErrorLog "| /usr/local/sbin/envylogger -e -t error.apache.%Y.%m.%d.log -u www-data -g www-data /var/www"`
    

# OPTIONS

Options are given in short format on the command line.

\-a Do not autoflush files. This may improve performance but may break logfile analyzers that depend on full entries in the logs.

\-e ErrorLog mode. In this mode, the host parsing is disabled, and the file is written out using the template under the specified LOGDIR.

\-n Disables rotation. This option disables rotation altogether.

\-f MAXFILES Maximum number of filehandles to keep open. Defaults to 100. Setting this value too high may result in the system running out of file descriptors. Setting it too low may affect performance.

\-u UID Change user to UID when running as root.

\-g GID Change group to GID when running as root.

\-t TEMPLATE Filename template using Date::Format codes. Default envy format is "access.apache.%Y.%m.%d.log", or "error.apache.%Y.%m.%d.log". When using the -r option, the default becomes "%m%d%Y-%T-access.log" or "%m%d%Y-%T-error.log".

\-s SYMLINK Specifies the name of a symlink to the current file.

\-r SIZE Rotate files when they reach SIZE. SIZE is given in bytes.

\-h Displays help.

\-v Prints version information.

# SEE ALSO

vlogger(1), cronolog(1), httplog(1)

# BUGS

None, yet.

# AUTHORS

Gergely Nagy <gna@r-us.hu>

WWW: [https://github.com/gnanet/envylogger](https://github.com/gnanet/envylogger)
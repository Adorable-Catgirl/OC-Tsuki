# Tsuki File Hierarchy, version 1

The root filesystem MUST contain the following directories:
* /boot - Contains files for booting the system (pre-Tsuki environment)
* /sys - Contains system executables and libraries
* /usr - Contains user-installed executables and libraries
* /home - Contains user directories for storing data
* /dev - Contains devfs
* /proc - Contains procfs
* /mnt - Contains mounted volumes
* /tmp - Contains the temporary filesystem
* /self - Symlink to the current running process's container
* /etc - Anything else

The root filesystem SHOULD contain:
* /var - Contains variable data (ie logs)
* /opt - Contains optional executables and libraries

The root filesystem MAY contain:
* /srv - Contains data for servers
* /root - Contains data for the root user
* /run - Contains runtime variable data
* /media - Contains mountpoints for removable media

## /sys
The /sys filesystem MUST contain the following directories:
* /bin - Contains binaries for executing
* /lib - Contains libraries for executing
* /share - Contains non-binary files
* /mods - Contains kernel modules, with subdirectories for different versions

The /sys filesystem SHOULD contain:
* /src - Source code of the kernel, modules, and required binaries

## /usr
The /usr filesystem MUST contain the following directories:
* /bin - Contains binaries for executing
* /lib - Contains libraries for executing
* /share - Contains non-binary files
* /mods - Contains kernel modules, with subdirectories for different versions

The /usr filesystem SHOULD contain:
* /src - Source code of user installed software

## /var
The /var filesystem MUST contain the following directories:
* /cache - Contains cached data from applications.
* /state - State information of libraries and programs
* /lock - Lock files.
* /log - Logs
* /spool - Queues
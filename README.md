Healthcheck
====

A simple shell-based health checking REST API that runs via /bin/sh

### Required System Calls

The script will call the following binaries from the `PATH`:
- `lsblk`: To determine what drives are available
- `uptime`: For system uptime
- `free`: For system memory information

For ZFS pool status, it will also call:
- `zpool status -x`
- `zfs list -Hp`

For drive status, it will call:
- `smartctl`: To get drive health

To serve web requests, `socat` is used

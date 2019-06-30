Healthcheck
====

A simple shell-based health checking REST API that runs via /bin/sh

### Required System Calls

The script will call the following binaries from the `PATH`:
- `lsblk -J`: To determine what drives are available
- `uptime`: For system uptime
- `free`: For system memory information

For ZFS pool status, it will also call:
- `zpool status -x`
- `zfs list -Hp`

For drive status, it will call:
- `hddtemp -A ${DRIVE}`: To get drive temperatures
- `smartctl -H ${DRIVE}`: To get drive health

To generate the JSON, `jq` is used

To serve web requests, `socat` is used

#!/bin/sh
cd "$(dirname "$0")"
socat UNIX-LISTEN:./healthcheck.sock,fork,unlink-early,unlink-close EXEC:./server.sh
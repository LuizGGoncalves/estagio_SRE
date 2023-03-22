#!/bin/bash
set -e

rm -f /estagioSRE/tmp/pids/server.pid

exec "$@"
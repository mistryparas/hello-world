#!/bin/sh
set -x
HOSTID=$(hostname | cut -d "-" -f4)
export INSTANCE_ID = $HOSTID

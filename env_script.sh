#!/bin/bash
HOSTID=$(hostname | cut -d "-" -f4)
echo "HOSTID=\"$HOSTID\"" > /opt/HOSTID
export HOST=$HOSTID

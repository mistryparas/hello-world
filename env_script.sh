#!/bin/sh
set -x
HOSTID=$(hostname | cut -d "-" -f4)
export INSTANCE_ID = $HOSTID
#excute java file 
java -jar /opt/backend.jar

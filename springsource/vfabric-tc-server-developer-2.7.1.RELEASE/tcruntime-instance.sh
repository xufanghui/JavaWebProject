#!/bin/bash
# ---------------------------------------------------------------------------
# tc Runtime Provisioning Script
#
# Copyright (c) 2010 VMware, Inc.  All rights reserved.
# ---------------------------------------------------------------------------
# version: 2.7.1.RELEASE
# build date: 20120709182635

if [ -z "$JAVA_HOME" ]
then
    echo The JAVA_HOME environment variable is not defined
    exit 1
fi

SCRIPT="$0"

# SCRIPT may be an arbitrarily deep series of symlinks. Loop until we have the concrete path.
while [ -h "$SCRIPT" ] ; do
  ls=`ls -ld "$SCRIPT"`
  # Drop everything prior to ->
  link=`expr "$ls" : '.*-> \(.*\)$'`
  if expr "$link" : '/.*' > /dev/null; then
    SCRIPT="$link"
  else
    SCRIPT=`dirname "$SCRIPT"`/"$link"
  fi
done

RUNTIME_DIR=`dirname "$SCRIPT"`
INSTANCE_DIR=$PWD

CLASSPATH=""

SAVEIFS=$IFS
IFS=$(echo -en "\n\b")

LIB_DIR=`dirname "$SCRIPT"`/lib
for file in $LIB_DIR/*
do
	if [[ $file == *.jar ]]
	then
	    if [ $CLASSPATH ]
		then	
	        CLASSPATH=$CLASSPATH:$file
	    else
	        CLASSPATH=$file
	    fi
	fi
done

$JAVA_HOME/bin/java $JAVA_OPTS "-Druntime.directory=$RUNTIME_DIR" "-Ddefault.instance.directory=$INSTANCE_DIR" -classpath "$CLASSPATH" com.springsource.tcruntime.instance.TcRuntimeInstance $*
EXIT_CODE=$?

IFS=$SAVEIFS

exit $EXIT_CODE

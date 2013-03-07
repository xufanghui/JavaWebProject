#!/bin/sh

# ---------------------------------------------------------------------------
# Copyright (c) 2010 VMware, Inc.  All rights reserved.
# ---------------------------------------------------------------------------

##
# This version calls the top-level tcruntime-ctl.sh
# script
##

INSTALL_BASE=${runtime.directory}

#

os400=false
darwin=false
case "`uname`" in
CYGWIN*) cygwin=true;;
OS400*) os400=true;;
Darwin*) darwin=true;;
esac

# resolve links - $0 may be a softlink
PRG="$0"

while [ -h "$PRG" ] ; do
  ls=`ls -ld "$PRG"`
  link=`expr "$ls" : '.*-> \(.*\)$'`
  if expr "$link" : '/.*' > /dev/null; then
    PRG="$link"
  else
    PRG=`dirname "$PRG"`/"$link"
  fi
done

PRGDIR=`dirname "$PRG"`
PRGDIR=`cd "$PRGDIR"; pwd -P`

#Guess instance name
BASEDIR=`cd "$PRGDIR/../." ; pwd -P`
INSTANCE_NAME=`basename $BASEDIR`

#Absolute path
PRGDIR=`cd "$PRGDIR/../../." ; pwd -P`

#Set instance base if it's not already set
if [ -z "$INSTANCE_BASE" ]; then
  INSTANCE_BASE="$PRGDIR"
  export INSTANCE_BASE
fi

EXECUTABLE=tcruntime-ctl.sh

PROGRAM=""

#first check install base

# Check that target executable exists
if [ -d "$INSTALL_BASE" ]; then
  if [ -x "$INSTALL_BASE"/"$EXECUTABLE" ]; then
    PROGRAM="$INSTALL_BASE"/"$EXECUTABLE"
  elif $os400; then
    # -x will Only work on the os400 if the files are:
    # 1. owned by the user
    # 2. owned by the PRIMARY group of the user
    # this will not work if the user belongs in secondary groups
    eval
    PROGRAM="$INSTALL_BASE"/"$EXECUTABLE"
  else
    echo "ERROR Cannot find $INSTALL_BASE/$EXECUTABLE or it's not executable."
  fi
fi

if [ -z "$PROGRAM" ]; then
  if [ ! -x "$PRGDIR"/"$EXECUTABLE" ]; then
    echo "ERROR Cannot find $PRGDIR/$EXECUTABLE or it's not executable."
    echo "ERROR One of these files is needed to run this program"
    exit 1
  else
    PROGRAM="$PRGDIR"/"$EXECUTABLE"
  fi
fi

if [ "verbose-status" = "$1" ]; then
  echo "Derived instance name: $INSTANCE_NAME"
  echo "Executing script:      $PROGRAM"
fi
exec "$PROGRAM" "$INSTANCE_NAME" "$1"

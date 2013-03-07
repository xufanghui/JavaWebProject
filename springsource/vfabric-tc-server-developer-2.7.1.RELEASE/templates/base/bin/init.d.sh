#!/bin/sh
#
# ---------------------------------------------------------------------------
# tc Runtime application server bootup script
#
# Copyright (c) 2009-2011 VMware, Inc.  All rights reserved.
# ---------------------------------------------------------------------------
# chkconfig: 2345 80 20
# description: Start up the tc Runtime application server
# version: 2.7.1.RELEASE
# build date: 20120709182635

# Source function library.

# The user account that will run the tc Runtime instance
TC_RUNTIME_USER="${runtime.user:tcserver}"

# DO NOT EDIT BEYOND THIS LINE
RETVAL=$?

setup () {
	PRG="$0"

	while [ -h "$PRG" ]; do
		ls=`ls -ld "$PRG"`
		link=`expr "$ls" : '.*-> \(.*\)$'`
		if expr "$link" : '/.*' > /dev/null; then
			PRG="$link"
		else
			PRG=`dirname "$PRG"`/"$link"
		fi
	done

	# Get standard environment variables
	PRGDIR=`dirname "$PRG"`

	#Absolute path
	PRGDIR=`cd "$PRGDIR" ; pwd -P`
}

stop() {
	if [ -x "$PRGDIR/tcruntime-ctl.sh" ]; then
		echo "Stopping tcServer"
		/bin/su $TC_RUNTIME_USER $PRGDIR/tcruntime-ctl.sh stop
		RETVAL=$?
	else
		echo "Startup script $PRGDIR/tcruntime-ctl.sh doesn't exist or is not executable."
		RETVAL=255
	fi
}

status() {
	if [ -x "$PRGDIR/tcruntime-ctl.sh" ]; then
		echo "Status-ing tcServer"
		/bin/su $TC_RUNTIME_USER $PRGDIR/tcruntime-ctl.sh status
		RETVAL=$?
	else
		echo "Startup script $PRGDIR/tcruntime-ctl.sh doesn't exist or is not executable."
		RETVAL=255
	fi
}

start() {
	if [ -x "$PRGDIR/tcruntime-ctl.sh" ]; then
		echo "Starting tcServer"
		/bin/su $TC_RUNTIME_USER $PRGDIR/tcruntime-ctl.sh start
		RETVAL=$?
	else
		echo "Startup script $PRGDIR/tcruntime-ctl.sh doesn't exist or is not executable."
		RETVAL=255
	fi
}

setup

case "$1" in
	start)
		start
		;;
	stop)
		stop
		;;
	restart)
		stop
		start
		;;
	status)
		status
		;;
	*)
		echo $"Usage: $0 {start|stop|restart|status}"
		exit 1
		;;
esac

exit $RETVAL

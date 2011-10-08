#!/bin/bash
# -----------------------------------------------------------------------------
#
# Shell script to start up the eXist command line client.
#
# $Id: setup.sh 8815 2009-04-08 18:00:43Z dizzzz $
# -----------------------------------------------------------------------------

# will be set by the installer
EXIST_HOME="C:\Program Files (x86)\eXist"

JAVA_HOME="C:\Program Files (x86)\Java\jdk1.7.0"

if [ ! -d "$JAVA_HOME" ]; then
    JAVA_HOME="C:\Program Files (x86)\Java\jdk1.7.0\jre"
fi

JAVA_CMD="$JAVA_HOME/bin/java"

OPTIONS=

if [ ! -f "$EXIST_HOME/start.jar" ]; then
	echo "Unable to find start.jar. EXIST_HOME = $EXIST_HOME"
	exit 1
fi

OPTIONS="-Dexist.home=$EXIST_HOME"

# set java options
if [ -z "$JAVA_OPTIONS" ]; then
	JAVA_OPTIONS="-Xms16000k -Xmx256000k"
fi

JAVA_ENDORSED_DIRS="$EXIST_HOME"/lib/endorsed

$JAVA_CMD $JAVA_OPTIONS $OPTIONS \
    -Djava.endorsed.dirs=$JAVA_ENDORSED_DIRS \
    -jar "$EXIST_HOME/start.jar" org.exist.Setup $*

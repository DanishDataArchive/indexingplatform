rem $Id: check_jmx_status.bat 6238 2007-07-14 19:55:33Z ellefj $
@echo off

set JMX_OPTS="-Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.port=%JMX_PORT% -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false"

if %JMX_ENABLED% == 0 goto :EOF
 set JAVA_OPTS=%JAVA_OPTS% %JMX_OPTS%

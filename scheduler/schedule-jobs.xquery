xquery version "1.0";

import module namespace scheduler = "http://exist-db.org/xquery/scheduler";
import module namespace scheduler-poperties = "http://dda.dk/ddi/scheduler-poperties" at "xmldb:exist:///db/apps/dda-denormalization/scheduler/properties.xquery";

let $login := xmldb:login("/db", $scheduler-poperties:username, $scheduler-poperties:password)

(: Cron expression that specifies Seconds: 0, Minutes: 0, Hours: 3, Day of month: any, Month: any, Day of week: unspecified :)
(: This means that it will run every tuesday at 00:00:00 every week :)
let $cron := "* * 0 ? * TUE" 

let $success := scheduler:schedule-xquery-cron-job("/db/apps/dda-denormalization/denormalize.xquery", $cron, $scheduler-poperties:jobName)

return if($success) then
            <result>The job was scheduled successfully</result>
       else
            <result>Job scheduling failed</result>

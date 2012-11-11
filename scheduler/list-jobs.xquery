xquery version "1.0";

import module namespace scheduler = "http://exist-db.org/xquery/scheduler";
import module namespace scheduler-poperties = "http://dda.dk/ddi/scheduler-poperties" at "xmldb:exist:///db/apps/dda-denormalization/scheduler/properties.xquery";

let $login := xmldb:login("/db", $scheduler-poperties:username, $scheduler-poperties:password)

let $scheduledJobs := scheduler:get-scheduled-jobs()
return $scheduledJobs
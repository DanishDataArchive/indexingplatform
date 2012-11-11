xquery version "1.0";

import module namespace scheduler = "http://exist-db.org/xquery/scheduler";

let $username := "admin"
let $password := "dda1"
let $login := xmldb:login("/db", $username, $password) 

(: Cron expression that specifies Seconds: 0, Minutes: 0, Hours: 3, Day of month: any, Month: any, Day of week: unspecified :)
(: This means that it will run every day at 03:00:00 regardless of the day of the week :)
let $cron := "0 0 3 * * ?" 

return scheduler:schedule-xquery-cron-job("/db/apps/dda-denormalization/denormalize.xquery", $cron, "Database denormalization") 

 
(:let $modules := util:registered-modules()
return
<results>{
   for $module in $modules
   order by $module
   return
      <module>{ $module}</module>
   }
</results>:)
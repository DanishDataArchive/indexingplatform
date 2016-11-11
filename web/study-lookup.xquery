xquery version "3.0";

import module namespace ddi = "http://dda.dk/ddi" at "xmldb:exist:///db/apps/dda/lib/search.xquery";

declare namespace output="http://www.w3.org/2010/xslt-xquery-serialization";
declare option output:media-type "text/xml";
declare option output:method "xml";

let $studyId := request:get-parameter("studyid", "0")
let $study :=  ddi:getDdiStudy($studyId)    

return $study

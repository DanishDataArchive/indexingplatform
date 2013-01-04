xquery version "1.0";

(:~
 : This module contains the functions used to .........
 :)
module namespace store = "http://dda.dk/ddi/store";

declare namespace xmldb="http://exist-db.org/xquery/xmldb";
declare namespace su="ddi:studyunit:3_1";


declare function store:storeDDI($ddi as element()?) as xs:string? {
    let $studyId := $ddi/su:StudyUnit/@id
    let $version := $ddi/su:StudyUnit/@version
    
    let $urnResourcePath := xmldb:store('/db/apps/dda-urn/data', concat($studyId, "-", $version, ".xml"), $ddi)
    
    let $result := if ($urnResourcePath) then
                       let $resourcePath := xmldb:store('/db/apps/dda/data', concat($studyId, ".xml"), $ddi)
                       return if ($resourcePath) then
                           <store:result success="true">
                               <message>
                               {
                                   concat("DDI document was stored in: '", $resourcePath, "' and urn: '", $urnResourcePath, "'.")
                                }
                                </message>
                           </store:result>
                       else
                           <store:result success="false">
                               <message>
                               {
                                   concat("Failed while storing DDI document in: '", $resourcePath, "'.")
                               }
                            </message>
                       </store:result>
                    else
                        <store:result success="false">
                            <message>
                            {
                                concat("Failed while storing DDI document for URN in: '", $urnResourcePath, "'.")
                            }
                            </message>
                        </store:result>
    
    return $result
};
xquery version "1.0";

declare namespace  xmldb="http://exist-db.org/xquery/xmldb";
declare namespace su="ddi:studyunit:3_1";

declare function local:main() as xs:string? {
    let $ddi := request:get-data()/*
    
    let $studyId := $ddi/su:StudyUnit/@id
    
    let $resourcePath := xmldb:store('/db/apps/dda/data', concat($studyId, ".xml"), $ddi)
    
    return concat("DDI document was stored in: '", $resourcePath, "'.")
};

local:main()